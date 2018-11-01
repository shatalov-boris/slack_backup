# frozen_string_literal: true

class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.text :name, null: false, index: true
      t.text :topic
      t.text :purpose

      t.string :slack_id, null: false, index: true
      t.string :creator_slack_id, null: false

      t.integer :channel_type, null: false
      t.integer :status, null: false

      t.integer :next_crawl_cycle, default: 1
      t.datetime :next_crawl_time
      t.datetime :latest_crawled
      t.datetime :oldest_crawled

      t.timestamps
    end
  end
end
