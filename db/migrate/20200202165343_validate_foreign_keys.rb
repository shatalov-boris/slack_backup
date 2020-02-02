# frozen_string_literal: true

class ValidateForeignKeys < ActiveRecord::Migration[6.0]
  def change
    validate_foreign_key "channel_members", "channels"
    validate_foreign_key "channel_members", "users"
    validate_foreign_key "channels", "teams"
    validate_foreign_key "messages", "channels"
    validate_foreign_key "messages", "users"
    validate_foreign_key "reactions", "messages"
    validate_foreign_key "user_reactions", "reactions"
    validate_foreign_key "user_reactions", "users"
    validate_foreign_key "users", "teams"
  end
end
