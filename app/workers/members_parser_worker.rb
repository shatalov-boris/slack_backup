class MembersParserWorker
  include Sidekiq::Worker

  def perform(user_info, team_id)
    Rails.logger.info("[MembersParserWorker] Started")
    user = UserBuilder.from_api(user_info)
    user.team_id = team_id
    user.save!
    Rails.logger.info("[MembersParserWorker] Finished for #{user.username}")
  end
end
