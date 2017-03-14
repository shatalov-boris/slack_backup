class AddTeamIdToChannel < ActiveRecord::Migration[5.0]
  def change
    add_reference :channels, :team, index: true
  end
end
