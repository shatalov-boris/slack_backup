# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :encrypted_password, :string
    change_column_default :users, :encrypted_password, from: nil, to: ""
    safety_assured { change_column_null :users, :encrypted_password, false }

    add_column :users, :remember_created_at, :datetime
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
