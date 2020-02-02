# frozen_string_literal: true

class RemoveOldestCrawledFromChannel < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      remove_column :channels, :oldest_crawled, :datetime
      remove_column :channels, :next_crawl_cycle, :integer
      remove_column :channels, :next_crawl_time, :datetime
    end
  end
end
