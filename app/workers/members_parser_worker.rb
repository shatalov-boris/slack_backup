# frozen_string_literal: true

class MembersParserWorker
  include Sidekiq::Worker

  sidekiq_options queue: "slack_parser"

  def perform(user_info, team_id)
    Rails.logger.info("[MembersParserWorker] Started")
    user = UserBuilder.from_api(user_info, team_id)

    unless user
      Rails.logger.info("[MembersParserWorker] Finished")
      return
    end

    if user.new_record? || user.changed?
      user.save!
      Rails.logger.info("[MembersParserWorker] Created new user #{user.username}")
    else
      Rails.logger.info("[MembersParserWorker] User #{user.username} without changes")
    end
  end
end
