class TeamsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = current_user.team
  end
end
