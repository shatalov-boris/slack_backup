class ChannelsParser
  def self.parse_all(user)
    slack_access_token = user.slack_access_token
    slack_api_client = SlackApiClient.new(slack_access_token)

    slack_api_client.public_channels&.each do |channel|
      ChannelParserWorker.perform_async(channel)
    end
    slack_api_client.private_channels&.each do |channel|
      ChannelParserWorker.perform_async(channel, true)
    end
    slack_api_client.direct_messages&.each do |channel|
      DirectMessageChannelParserWorker.perform_async(user.id, channel)
    end
  end
end
