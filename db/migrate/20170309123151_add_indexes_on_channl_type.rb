# frozen_string_literal: true

class AddIndexesOnChannlType < ActiveRecord::Migration[5.0]
  def change
    add_index :channels, :channel_type
    add_index :channels, :status
  end
end
