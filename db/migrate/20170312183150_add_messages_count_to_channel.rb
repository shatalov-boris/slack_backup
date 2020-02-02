# frozen_string_literal: true

class AddMessagesCountToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :messages_count, :integer
    change_column_default :channels, :messages_count, from: nil, to: 0

    reversible do |dir|
      safety_assured { dir.up { data } }
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
