# frozen_string_literal: true

class AddIndexesOnChannlType < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :channels, :channel_type, algorithm: :concurrently
    add_index :channels, :status, algorithm: :concurrently
  end
end
