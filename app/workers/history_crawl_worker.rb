class HistoryCrawlWorker
  include Sidekiq::Worker

  def perform(channel_id)
    Rails.logger.info("[HistoryCrawlWorker] Started")

    channel = Channel.find(channel_id)
    slack_access_token = channel.user_with_access&.slack_access_token

    unless slack_access_token
      Rails.logger.info("[HistoryCrawlWorker] Can't get access token for Channel with ID = #{channel.id}")
      return
    end

    channel.update!(oldest_crawled: DateTime.current, latest_crawled: DateTime.current) if channel.oldest_crawled.nil?

    crawl_by_oldest(channel, slack_access_token)
    crawl_by_latest(channel, slack_access_token)

    channel.next_crawl_time += channel.next_crawl_cycle.hours
    channel.save!

    Rails.logger.info("[HistoryCrawlWorker] Finished for Channel ID = #{channel.id}")
  end

  private

  def crawl_by_oldest(channel, slack_access_token)
    epoch = Time.at(0)
    slack_api_client = SlackApiClient.new(slack_access_token)

    while channel.oldest_crawled > epoch
      history = slack_api_client.channel_history(channel, oldest: true)
      messages = history["messages"]

      if messages&.any?
        latest = messages[-1]["ts"]
        has_more = history["has_more"]
        channel.oldest_crawled = has_more ? Time.at(latest.to_d) : epoch
        MessageAdder.add(messages, channel)
      else
        channel.oldest_crawled = epoch
      end
    end
  end

  def crawl_by_latest(channel, slack_access_token)
    now = DateTime.current

    slack_api_client = SlackApiClient.new(slack_access_token)
    while channel.latest_crawled < now
      channel.latest_crawled += 12.hours
      channel.latest_crawled = now if channel.latest_crawled > now

      history = slack_api_client.channel_history(channel, latest: true)
      messages = history["messages"]

      if messages&.any?
        MessageAdder.add(messages, channel)
      else
        channel.latest_crawled = now
      end
    end
  end
end
