class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @opened_channels = current_user.channels.includes(:users).opened.to_a.group_by(&:channel_type)
    @archived_channels = current_user.channels.archived
  end

  def show
    @channel = current_user.channels.find(params[:id])
    @messages = @channel.messages.includes(:user).order(ts: :desc).page(params[:page]).per(20)
  end
end
