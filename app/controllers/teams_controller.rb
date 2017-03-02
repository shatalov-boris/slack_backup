class TeamsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = current_user.team
  end

  def user
    @user = User.find(params[:slug])
  end
end
