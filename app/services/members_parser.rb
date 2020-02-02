# frozen_string_literal: true

class MembersParser
  def call(team, slack_access_token)
    slack_api_client = SlackApiClient.new(slack_access_token)

    members = parse_members(slack_api_client, team.id)
    members = parse_members(slack_api_client, team.id, members["response_metadata"]&.dig("next_cursor")) while members["has_more"]
  end

  private

  def parse_members(slack_api_client, team_id, cursor = nil)
    members = slack_api_client.team_members(cursor: cursor)

    members["members"]&.each do |member|
      MembersParserWorker.perform_async(member, team_id)
    end

    members
  end
end
