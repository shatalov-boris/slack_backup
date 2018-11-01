# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true
      t.belongs_to :channel, index: true
      t.integer :message_type, null: false
      t.boolean :hidden
      t.text :text, null: false
      t.datetime :ts

      t.timestamps
    end
  end
end
