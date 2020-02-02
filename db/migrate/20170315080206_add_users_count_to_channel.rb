# frozen_string_literal: true

class AddUsersCountToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :users_count, :integer
    change_column_default :channels, :users_count, from: nil, to: 0

    reversible do |dir|
      safety_assured { dir.up { data } }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE channels
           SET users_count = (SELECT count(1)
                                FROM channel_members
                                WHERE channel_members.channel_id = channels.id)
    SQL
  end
end
