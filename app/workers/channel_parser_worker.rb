class ChannelParserWorker
  include Sidekiq::Worker

  def perform(parsed_channel, channel_type)
    Rails.logger.info("[ChannelParserWorker] Started")

    channel = Channel.find_or_initialize_by(slack_id: parsed_channel["id"])
    channel.name = parsed_channel["name"]
    channel.creator_slack_id = parsed_channel["creator"]
    channel.topic = parsed_channel["topic"]["value"] if parsed_channel["topic"]
    channel.purpose = parsed_channel["purpose"]["value"] if parsed_channel["purpose"]
    channel.status = parsed_channel["is_archived"] ? :archived : :opened
    channel.channel_type = channel_type
    channel.save! if channel.new_record? || channel.changed?

    channel.channel_members.destroy_all
    channel.users = User.where(slack_id: parsed_channel["members"])

    Rails.logger.info("[ChannelParserWorker] Finished for Channel with ID = #{channel.id}")
  end
end
