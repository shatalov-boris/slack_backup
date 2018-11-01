# frozen_string_literal: true

class ChannelBuilder
  def self.build_from_json(json_channel, is_private = false)
    Channel.find_or_initialize_by(slack_id: json_channel["id"]) do |channel|
      channel.name = json_channel["name"]
      channel.creator_slack_id = json_channel["creator"]
      channel.topic = json_channel["topic"]["value"] if json_channel["topic"]
      channel.purpose = json_channel["purpose"]["value"] if json_channel["purpose"]
      channel.status = json_channel["is_archived"] ? :archived : :opened
      channel.channel_type = if is_private
                               json_channel["is_mpim"] ? :group_message : :private_channel
                             else
                               :public_channel
                             end
    end
  end
end
