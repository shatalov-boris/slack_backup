# frozen_string_literal: true

class AddUserToTeam < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_reference :users, :team, type: :integer, index: { algorithm: :concurrently }
  end
end
