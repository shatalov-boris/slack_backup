class ChannelsParser
  def self.parse_all(slack_access_token)
    slack_api_client = SlackApiClient.new(slack_access_token)

    slack_api_client.public_channels&.each do |channel|
      ChannelParserWorker.perform_async(channel, false)
    end
    slack_api_client.private_channels&.each do |channel|
      ChannelParserWorker.perform_async(channel, true)
    end
  end
end
