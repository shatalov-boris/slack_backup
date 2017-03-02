class ChannelParser
  def self.parse_all(slack_access_token)
    slack_api_client = SlackApiClient.new(slack_access_token)
    parse(slack_api_client.public_channels, false)

    slack_api_client = SlackApiClient.new(slack_access_token)
    parse(slack_api_client.private_channels, true)
  end

  def self.parse(parsed_channels, is_private)
    parsed_channels.each do |parsed_channel|
      channel = Channel.find_or_initialize_by(slack_id: parsed_channel["id"])
      channel.name = parsed_channel["name"]
      channel.creator_slack_id = parsed_channel["creator"]
      channel.topic = parsed_channel["topic"]["value"] if parsed_channel["topic"]
      channel.purpose = parsed_channel["purpose"]["value"] if parsed_channel["purpose"]
      channel.status = channel["is_archived"] ? :archived : :opened
      channel.channel_type = is_private ? :private_channel : :public_channel
      channel.save!

      parsed_channel["members"]&.each do |member_id|
        user = User.find_by(slack_id: member_id)
        channel.users << user if user
      end
    end
  end
end
