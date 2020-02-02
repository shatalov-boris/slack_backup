# frozen_string_literal: true

class AddTeamIdToChannel < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_reference :channels, :team, type: :integer, index: { algorithm: :concurrently }
  end
end
