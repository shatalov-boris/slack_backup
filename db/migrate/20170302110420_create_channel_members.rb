class CreateChannelMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_members do |t|
      t.belongs_to :channel, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end

    add_index :channel_members, %i[channel_id user_id], unique: true
  end
end
