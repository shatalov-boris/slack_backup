class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.belongs_to :message, index: true, null: false
      t.text :name, null: false

      t.timestamps
    end

    add_index :reactions, :name
  end
end
