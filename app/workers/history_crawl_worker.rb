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
      history = slack_api_client.channel_history(channel, private: channel.private_channel?, oldest: true)
      messages = history["messages"]

      if messages&.any?
        latest = messages[-1]["ts"]
        has_more = history["has_more"]
        channel.oldest_crawled = has_more ? Time.at(latest.to_d) : epoch
        add_messages(messages, channel)
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

      history = slack_api_client.channel_history(channel, private: channel.private_channel?, latest: true)
      messages = history["messages"]

      if messages&.any?
        add_messages(messages, channel)
      else
        channel.latest_crawled = now
      end
    end
  end

  def add_messages(messages, channel)
    messages.each do |message|
      user = User.find_by(slack_id: message["user"])

      unless user
        Rails.logger.info("[HistoryCrawlWorker] There is no User with slack_id = #{message['user']}")
        next
      end

      new_message = user.messages.find_or_initialize_by(message_type: message["type"],
                                                        ts: Time.at(message["ts"].to_d),
                                                        channel: channel)
      new_message.text = message["text"]
      new_message.save! if new_message.new_record? || new_message.changed?

      message["reactions"]&.each do |reaction|
        ar_reaction = new_message.reactions.find_or_create_by!(name: reaction["name"])
        ar_reaction.users = User.where(slack_id: reaction["users"])
      end
    end
  end
end
