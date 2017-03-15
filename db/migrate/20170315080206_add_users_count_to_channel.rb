class AddUsersCountToChannel < ActiveRecord::Migration[5.0]
  def change
    change_table :channels do |t|
      t.integer :users_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
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
