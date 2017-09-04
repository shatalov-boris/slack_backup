class MessagesController < ApplicationController
  before_action :authenticate_user!

  def search
    searchable_channels_ids = current_user.channels.ids

    if params[:q].blank?
      flash[:notice] = "You must specify search query."
      return redirect_back(fallback_location: root_path)
    end

    params[:q]&.strip!

    if params[:channel_id].present?
      @channel = current_user.channels.find(params[:channel_id])
      if @channel.id.in?(searchable_channels_ids)
        searchable_channels_ids = @channel.id
      else
        flash[:alert] = "You are not member of this channel."
        return redirect_back(fallback_location: root_path)
      end
    end

    @messages = Message
                  .where("text ~* :pattern", pattern: params[:q])
                  .where(channel_id: searchable_channels_ids)
                  .includes(:user, :channel, reactions: :users)
                  .order(ts: :desc)
                  .page(params[:page])
                  .per(20)
  end
end
