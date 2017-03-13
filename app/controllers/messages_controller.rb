class MessagesController < ApplicationController
  def search
    searchable_channels_ids = current_user.channels.ids

    return redirect_to :back, fallback_location: root_path, notice: "You must specify search query." if params[:q].blank?

    if params[:channel_id].present?
      @channel = Channel.find(params[:channel_id])
      if @channel.id.in?(searchable_channels_ids)
        searchable_channels_ids = @channel.id
      else
        redirect_to :back, fallback_location: root_path, alert: "You are not member of this channel."
      end
    end

    @messages = Message
                  .basic_search(text: params[:q])
                  .where(channel_id: searchable_channels_ids)
                  .includes(:user, :channel, reactions: :users)
                  .order(ts: :desc)
                  .page(params[:page])
                  .per(20)
  end
end
