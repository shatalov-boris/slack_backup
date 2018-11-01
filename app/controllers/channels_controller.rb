class ChannelsController < AuthenticatedUserController
  def index
    @opened_channels = current_user
                         .channels
                         .with_messages
                         .includes(:users)
                         .opened
                         .recent
                         .to_a
                         .group_by(&:channel_type)
    @archived_channels = current_user
                           .channels
                           .with_messages
                           .archived
                           .recent
  end

  def show
    @channel = current_user.channels.with_messages.find(params[:id])
    @messages = @channel
                  .messages
                  .includes(:user, reactions: :users)
                  .order(ts: :desc)
                  .page(params[:page])
                  .per(20)
  end
end
