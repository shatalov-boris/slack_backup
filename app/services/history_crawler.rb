class HistoryCrawler
  def self.crawl_all
    Channel.find_each do |channel|
      HistoryCrawlWorker.perform_async(channel.id)
    end
  end
end
