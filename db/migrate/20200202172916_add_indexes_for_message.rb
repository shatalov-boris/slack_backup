# frozen_string_literal: true

class AddIndexesForMessage < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :messages, :message_type, algorithm: :concurrently
    add_index :messages, :ts, algorithm: :concurrently
  end
end
