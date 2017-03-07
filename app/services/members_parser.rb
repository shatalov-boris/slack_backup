class MembersParser
  def self.parse_all(team, slack_access_token)
    SlackApiClient.new(slack_access_token).team_members&.each do |member|
      MembersParserWorker.perform_async(member, team.id)
    end
  end
end
