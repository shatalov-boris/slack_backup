class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :slack_access_token, null: false
      t.string :slack_id, null: false
      t.string :avatar, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
