class ChannelParserWorker
  include Sidekiq::Worker

  def perform(parsed_channel, team_id, is_private = false)
    Rails.logger.info("[ChannelParserWorker] Started")
    
    team = Team.find(team_id)
    channel = ChannelBuilder.build_from_json(parsed_channel, is_private)
    channel.team_id = team.id
    channel.save! if channel.new_record? || channel.changed?

    channel.channel_members.destroy_all
    channel.users = is_private ? team.users.where(slack_id: parsed_channel["members"]) : team.users

    Rails.logger.info("[ChannelParserWorker] Finished for Channel with ID = #{channel.id}")
  end
end
