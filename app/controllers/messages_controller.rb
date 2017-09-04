class MessagesController < ApplicationController
  before_action :authenticate_user!

  def search
    searchable_channels_ids = current_user.channels.ids

    return redirect_to :back, fallback_location: root_path, notice: "You must specify search query." if params[:q].blank?
    params[:q]&.strip!

    if params[:channel_id].present?
      @channel = current_user.channels.find(params[:channel_id])
      if @channel.id.in?(searchable_channels_ids)
        searchable_channels_ids = @channel.id
      else
        redirect_to :back, fallback_location: root_path, alert: "You are not member of this channel."
      end
    end

    @messages = Message
                    .where('text ~* :pattern', pattern: params[:q])
                    .where(channel_id: searchable_channels_ids)
                    .includes(:user, :channel, reactions: :users)
                    .order(ts: :desc)
                    .page(params[:page])
                    .per(20)
  end
end
