# frozen_string_literal: true

class AddKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "channel_members", "channels", name: "channel_members_channel_id_fk", validate: false
    add_foreign_key "channel_members", "users", name: "channel_members_user_id_fk", validate: false
    add_foreign_key "channels", "teams", name: "channels_team_id_fk", validate: false
    add_foreign_key "messages", "channels", name: "messages_channel_id_fk", validate: false
    add_foreign_key "messages", "users", name: "messages_user_id_fk", validate: false
    add_foreign_key "reactions", "messages", name: "reactions_message_id_fk", validate: false
    add_foreign_key "user_reactions", "reactions", name: "user_reactions_reaction_id_fk", validate: false
    add_foreign_key "user_reactions", "users", name: "user_reactions_user_id_fk", validate: false
    add_foreign_key "users", "teams", name: "users_team_id_fk", validate: false
  end
end
