require "rest-client"

class SlackApiClient
  include Rails.application.routes.url_helpers

  def initialize(slack_access_token)
    @client_id = ENV["SLACK_CLIENT_ID"]
    @client_secret = ENV["SLACK_CLIENT_SECRET"]
    @slack_access_token = slack_access_token
  end

  def team_members
    url = "https://slack.com/api/users.list?token=#{@slack_access_token}"
    response = RestClient.get(url)
    JSON.parse(response.body)["members"]
  end

  def public_channels
    url = "https://slack.com/api/channels.list?token=#{@slack_access_token}"
    response = RestClient.get(url)
    JSON.parse(response.body)["channels"]
  end

  def private_channels
    url = "https://slack.com/api/groups.list?token=#{@slack_access_token}"
    response = RestClient.get(url)
    JSON.parse(response.body)["groups"]
  end
end
