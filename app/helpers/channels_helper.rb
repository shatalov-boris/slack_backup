module ChannelsHelper
  def channel_name(channel)
    if channel.direct_message?
      return current_user.username if channel.users.size == 1
      channel.users.to_a.delete_if { |user| user == current_user }.first.username
    else
      channel.name
    end
  end
end
