class OauthController < ApplicationController
  def slack_oauth
    state = SecureRandom.urlsafe_base64(10)
    session[:state] = state

    url = "https://slack.com/oauth/authorize?client_id=#{ENV["SLACK_CLIENT_ID"]}&state=#{state}"\
          + "&scope=identify channels:history channels:read users:read users:read.email groups:read groups:history&redirect_uri="\
          + slack_oauth_callback_url

    redirect_to url
  end
end
