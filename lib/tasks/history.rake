namespace :slack_backup do
  desc "parse channels messages"
  task history_parse: :environment do
    HistoryCrawler.crawl_all
  end
end
