class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :username, null: false, default: ""
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.string :slack_access_token, default: ""
      t.string :slack_id, null: false, default: ""
      t.string :avatar, default: ""

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
