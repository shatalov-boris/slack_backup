# frozen_string_literal: true

class DirectMessageChannelParserWorker
  include Sidekiq::Worker

  def perform(user_id, team_id, parsed_channel)
    Rails.logger.info("[ChannelParserWorker] Started")

    team = Team.find(team_id)
    user = team.users.find(user_id)

    partner = team.users.find_by(slack_id: parsed_channel["user"])
    unless partner
      Rails.logger.info("[ChannelParserWorker] Can not find user with slack ID #{parsed_channel['user']}")
      return
    end

    channel = Channel.find_or_initialize_by(slack_id: parsed_channel["id"])
    channel.team_id = team.id
    channel.name = ""
    channel.creator_slack_id = ""
    channel.status = :opened
    channel.channel_type = :direct_message
    channel.save! if channel.new_record? || channel.changed?

    channel.users = [user]
    channel.users << partner if user != partner

    Rails.logger.info("[ChannelParserWorker] Finished for Channel with ID = #{channel.id}")
  end
end
