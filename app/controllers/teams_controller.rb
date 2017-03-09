class TeamsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = current_user.team
  end

  def user
    @user = current_user.team.users.find(params[:slug])
    @messages = @user
                  .messages
                  .joins(channel: :users)
                  .where(users: { id: current_user.id })
                  .includes(channel: :users)
                  .order(ts: :desc)
                  .page(params[:page])
                  .per(20)
  end
end
