# frozen_string_literal: true

class AddSlugToUser < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true, algorithm: :concurrently
  end
end
