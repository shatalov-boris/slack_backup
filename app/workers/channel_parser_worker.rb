class ChannelParserWorker
  include Sidekiq::Worker

  def perform(parsed_channel, is_private)
    Rails.logger.info("[ChannelParserWorker] Started")

    channel = Channel.find_or_initialize_by(slack_id: parsed_channel["id"])
    channel.name = parsed_channel["name"]
    channel.creator_slack_id = parsed_channel["creator"]
    channel.topic = parsed_channel["topic"]["value"] if parsed_channel["topic"]
    channel.purpose = parsed_channel["purpose"]["value"] if parsed_channel["purpose"]
    channel.status = parsed_channel["is_archived"] ? :archived : :opened
    channel.channel_type = is_private ? :private_channel : :public_channel
    channel.save!

    channel.channel_members.destroy_all
    parsed_channel["members"]&.each do |member_id|
      user = User.find_by(slack_id: member_id)
      channel.users << user if user
    end

    Rails.logger.info("[ChannelParserWorker] Finished for Channel with ID = #{channel.id}")
  end
end
