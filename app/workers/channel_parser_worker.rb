class ChannelParserWorker
  include Sidekiq::Worker

  def perform(parsed_channel, is_private = false)
    Rails.logger.info("[ChannelParserWorker] Started")

     channel = ChannelBuilder.build_from_json(parsed_channel, is_private)
    channel.save! if channel.new_record? || channel.changed?

    channel.channel_members.destroy_all
    channel.users = User.where(slack_id: parsed_channel["members"])

    Rails.logger.info("[ChannelParserWorker] Finished for Channel with ID = #{channel.id}")
  end
end
