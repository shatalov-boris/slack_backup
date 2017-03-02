require "rest-client"

class SlackApiClient
  include Rails.application.routes.url_helpers

  def initialize
    @client_id = ENV["SLACK_CLIENT_ID"]
    @client_secret = ENV["SLACK_CLIENT_SECRET"]
  end

  def access_token(code)
    url = "https://slack.com/api/oauth.access?client_id=#{@client_id}&client_secret=#{@client_secret}"\
          + "&code=#{code}&redirect_uri=#{slack_oauth_callback_url}"

    response = RestClient.get(url)
    JSON.parse(response.body)["access_token"]
  end

  def user_id(access_token)
    url = "https://slack.com/api/auth.test?token=#{access_token}"

    response = RestClient.get(url)
    JSON.parse(response.body)["user_id"]
  end

  def user_info(access_token, slack_user_id)
    url = "https://slack.com/api/users.info?token=#{access_token}&user=#{slack_user_id}"

    response = RestClient.get(url)
    JSON.parse(response.body)
  end

  def team_info(access_token)
    url = "https://slack.com/api/team.info?token=#{access_token}"

    response = RestClient.get(url)
    JSON.parse(response.body)["team"]
  end
end
