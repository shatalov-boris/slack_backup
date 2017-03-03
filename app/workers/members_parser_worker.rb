class MembersParserWorker
  include Sidekiq::Worker

  def perform(team_id, slack_access_token)
    team = Team.find(team_id)
    members = SlackApiClient.new(slack_access_token).team_members

    members.each do |member|
      UserBuilder.from_api(member)&.update!(team: team)
    end
  end
end