# frozen_string_literal: true

class AddUsersCountToReaction < ActiveRecord::Migration[5.0]
  def change
    add_column :reactions, :users_count, :integer
    change_column_default :reactions, :users_count, from: nil, to: 0

    reversible do |dir|
      safety_assured { dir.up { data } }
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
