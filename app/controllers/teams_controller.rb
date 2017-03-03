class TeamsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = current_user.team
  end

  def user
    @user = current_user.team.users.find(params[:slug])
    @messages = @user.messages.includes(:channel).page(params[:page]).per(20)
  end
end
