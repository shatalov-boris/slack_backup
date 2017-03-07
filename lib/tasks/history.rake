namespace :slack_backup do
  desc "parse channels"
  task channels_parse: :environment do
    User.find_each do |user|
      ChannelsParser.parse_all(user)
    end
  end

  desc "parse members"
  task members_parse: :environment do
    Team.find_each do |team|
      MembersParser.parse_all(team, team.users
                                        .keep_if { |user| user.slack_access_token.present? }
                                        .sample
                                        .slack_access_token)
    end
  end

  desc "parse channels messages"
  task history_parse: :environment do
    HistoryCrawler.crawl_all
  end
end
