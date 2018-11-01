# frozen_string_literal: true

class AddMessagesCountToChannel < ActiveRecord::Migration[5.0]
  def change
    change_table :channels do |t|
      t.integer :messages_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE channels
           SET messages_count = (SELECT count(1)
                                   FROM messages
                                   WHERE messages.channel_id = channels.id)
    SQL
  end
end
