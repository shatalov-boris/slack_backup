require "rest-client"

class SlackApiClient
  def initialize(slack_access_token)
    @client_id = ENV["SLACK_CLIENT_ID"]
    @client_secret = ENV["SLACK_CLIENT_SECRET"]
    @slack_access_token = slack_access_token
  end

  def team_members
    response = RestClient.get(api_url("users.list"))
    JSON.parse(response.body)["members"]
  end

  def public_channels
    response = RestClient.get(api_url("channels.list"))
    JSON.parse(response.body)["channels"]
  end

  def private_channels
    response = RestClient.get(api_url("groups.list"))
    JSON.parse(response.body)["groups"]
  end

  def direct_messages
    response = RestClient.get(api_url("im.list"))
    JSON.parse(response.body)["ims"]
  end

  def channel_history(channel, options = {})
    endpoint = options[:private] ? "groups.history" : "channels.history"
    url = api_url(endpoint) + "&channel=#{channel.slack_id}"

    if options[:oldest]
      url += "&latest=#{channel.oldest_crawled.to_i}"
    elsif options[:latest]
      url += "&oldest=#{channel.oldest_crawled.to_i}&latest=#{channel.latest_crawled.to_i}"
    end

    response = RestClient.get(url)
    JSON.parse(response.body)
  end

  private

  def api_url(endpoint)
    "https://slack.com/api/#{endpoint}?token=#{@slack_access_token}"
  end
end
