# frozen_string_literal: true

class SlackApiClient
  def initialize(slack_access_token)
    @client_id = ENV["SLACK_CLIENT_ID"]
    @client_secret = ENV["SLACK_CLIENT_SECRET"]
    @slack_access_token = slack_access_token
  end

  def team_members
    response = RestClient.get(api_url("users.list"))
    Oj.load(response.body)["members"]
  end

  def public_channels
    response = RestClient.get(api_url("channels.list"))
    Oj.load(response.body)["channels"]
  end

  def private_channels
    response = RestClient.get(api_url("groups.list"))
    Oj.load(response.body)["groups"]
  end

  def direct_messages
    response = RestClient.get(api_url("im.list"))
    Oj.load(response.body)["ims"]
  end

  def channel_history(channel, options = {})
    endpoint = case channel.channel_type.to_sym
               when :public_channel
                 "channels.history"
               when :private_channel, :group_message
                 "groups.history"
               when :direct_message
                 "im.history"
               else
                 raise "unexpected channel type - #{channel.channel_type}"
               end
    url = api_url(endpoint) + "&channel=#{channel.slack_id}"

    if options[:oldest]
      url += "&latest=#{channel.oldest_crawled.to_i}"
    elsif options[:latest]
      url += "&oldest=#{channel.oldest_crawled.to_i}&latest=#{channel.latest_crawled.to_i}"
    end

    response = RestClient.get(url)
    Oj.load(response.body)
  end

  private

  def api_url(endpoint)
    "https://slack.com/api/#{endpoint}?token=#{@slack_access_token}"
  end
end
