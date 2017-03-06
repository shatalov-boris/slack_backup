class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_channels = current_user.channels.opened
    @archived_channels = current_user.channels.archived
  end

  def show
    @channel = current_user.channels.find(params[:id])
    @messages = @channel.messages.includes(:user).order(ts: :desc).page(params[:page]).per(20)
  end
end
