class AddReactionsCountToMessages < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.integer :reactions_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE messages
           SET reactions_count = (SELECT count(1)
                                  FROM reactions
                                  WHERE reactions.message_id = messages.id)
    SQL
  end
end
