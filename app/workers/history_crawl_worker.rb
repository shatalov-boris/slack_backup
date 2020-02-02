# frozen_string_literal: true

class HistoryCrawlWorker
  include Sidekiq::Worker

  sidekiq_options queue: "slack_parser"

  def perform(channel_id)
    Rails.logger.info("[HistoryCrawlWorker] Started")

    channel = Channel.find(channel_id)
    slack_access_token = channel.user_with_access&.slack_access_token

    unless slack_access_token
      Rails.logger.info("[HistoryCrawlWorker] Can't get access token for Channel with ID = #{channel.id}")
      return
    end

    channel.latest_crawled = Time.zone.at(0) unless channel.latest_crawled
    slack_api_client = SlackApiClient.new(slack_access_token)

    history = add_messages(channel, slack_api_client)
    history = add_messages(channel, slack_api_client, history["response_metadata"]&.dig("next_cursor")) while history["has_more"]

    channel.update!(latest_crawled: Time.current)

    Rails.logger.info("[HistoryCrawlWorker] Finished for Channel ID = #{channel.id}")
  end

  private

  def add_messages(channel, slack_api_client, cursor = nil)
    history = slack_api_client.channel_history(channel, cursor)

    messages = history["messages"]
    MessageAdder.add(messages, channel) if messages&.any?

    history
  end
end
