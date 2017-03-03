class CreateUserReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_reactions do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :reaction, index: true, null: false

      t.timestamps
    end

    add_index :user_reactions, [:user_id, :reaction_id], unique: true
  end
end
