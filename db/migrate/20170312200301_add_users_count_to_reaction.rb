class AddUsersCountToReaction < ActiveRecord::Migration[5.0]
  def change
    change_table :reactions do |t|
      t.integer :users_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE reactions
           SET users_count = (SELECT count(1)
                                 FROM user_reactions
                                 WHERE user_reactions.reaction_id = reactions.id)
    SQL
  end
end
