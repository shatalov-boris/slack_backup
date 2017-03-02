class ChannelParserWorker
  include Sidekiq::Worker

  def perform(slack_access_token)
    ChannelParser.parse_all(slack_access_token)
  end
end
