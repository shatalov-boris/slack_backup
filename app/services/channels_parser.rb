# frozen_string_literal: true

class ChannelsParser
  def call(user)
    slack_access_token = user.slack_access_token
    slack_api_client = SlackApiClient.new(slack_access_token)

    list = parse_channels(slack_api_client, user)
    list = parse_channels(slack_api_client, user, list["response_metadata"]&.dig("next_cursor")) while list["has_more"]
  end

  private

  def parse_channels(slack_api_client, user, cursor = nil)
    list = slack_api_client.conversations_list(types: "public_channel,private_channel,im", cursor: cursor)

    list["channels"]&.each do |channel|
      if channel["is_private"]
        ChannelParserWorker.perform_async(channel, user.team_id, true)
      elsif channel["is_im"]
        DirectMessageChannelParserWorker.perform_async(user.id, user.team_id, channel)
      else
        ChannelParserWorker.perform_async(channel, user.team_id)
      end
    end

    list
  end
end
