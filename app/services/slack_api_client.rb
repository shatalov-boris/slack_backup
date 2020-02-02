# frozen_string_literal: true

class SlackApiClient
  def initialize(slack_access_token)
    @client_id = ENV.fetch("SLACK_CLIENT_ID")
    @client_secret = ENV.fetch("SLACK_CLIENT_SECRET")
    @slack_access_token = slack_access_token
  end

  def team_members(cursor: nil)
    url = api_url("users.list")
    url += "&cursor=#{cursor}" if cursor

    response = RestClient.get(url)
    JSON.load(response.body)
  end

  def conversations_list(types: nil, cursor: nil)
    url = api_url("conversations.list")
    url += "&types=#{types}" if types.present?
    url += "&cursor=#{cursor}" if cursor

    response = RestClient.get(url)
    JSON.load(response.body)
  end

  def channel_history(channel, cursor = nil)
    url = api_url("conversations.history") + "&channel=#{channel.slack_id}"
    url += "&oldest=#{channel.latest_crawled.to_i}" if channel.latest_crawled
    url += "&cursor=#{cursor}" if cursor

    response = RestClient.get(url)
    JSON.load(response.body)
  end

  private

  def api_url(endpoint)
    "https://slack.com/api/#{endpoint}?token=#{@slack_access_token}"
  end
end
