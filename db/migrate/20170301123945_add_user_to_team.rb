class AddUserToTeam < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :team, null:false, index: true
  end
end
