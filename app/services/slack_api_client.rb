require "rest-client"

class SlackApiClient
  include Rails.application.routes.url_helpers

  def initialize
    @client_id = ENV["SLACK_CLIENT_ID"]
    @client_secret = ENV["SLACK_CLIENT_SECRET"]
  end

  def team_members(slack_access_token)
    url = "https://slack.com/api/users.list?token=#{slack_access_token}"

    response = RestClient.get(url)
    JSON.parse(response.body)["members"]
  end
end
