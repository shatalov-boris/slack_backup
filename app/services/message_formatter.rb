# How to display formatted messages
# https://api.slack.com/docs/message-formatting
#
# 1. Detect all sequences matching <(.*?)>
# 2. Within those sequences, format content starting with #C as a channel link
# 3. Within those sequences, format content starting with @U as a user link
# 4. Within those sequences, format content starting with
#    ! according to the rules for the special command.
# 5. For remaining sequences, format as a link
# 6. Once the format has been determined, check for a pipe - if present, use
#    the text following the pipe as the link label

class MessageFormatter
  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers

  def initialize(message)
    @message = message
  end

  def format
    user_ids = @message.scan(/<@U(.*?)>/)
    user_ids.each { |user_id| @message.gsub!("<@U#{user_id[0]}>", user_link(user_id[0])) }

    channel_ids = @message.scan(/<#C(.*?)>/)
    channel_ids.each { |channel_id| @message.gsub!("<#C#{channel_id[0]}>", channel_link(channel_id[0])) }

    mentions = @message.scan(/<!(.*?)>/)
    mentions.each { |mention| @message.gsub!("<!#{mention[0]}>", mention(mention[0])) }

    links = @message.scan(/<https:\/\/(.*?)>/)
    links.each { |link| @message.gsub!("<https://#{link[0]}>", link("https://#{link[0]}")) }

    markup_format(@message).html_safe
  end

  private

  def user_link(text)
    user = User.find_by(slack_id: "U#{text.split('|')[0]}")
    return "" unless user
    content_tag(:a, "@#{user.username}", href: member_team_path(user))
  end

  def channel_link(text)
    channel = Channel.find_by(slack_id: "U#{text.split('|')[0]}")
    return "" unless channel
    content_tag(:a, "@#{channel.name}", href: channel_path(channel))
  end

  def link(text)
    url = text.split("|")[0]
    pipe = text.split("|")[1]
    content_tag(:a, pipe || url, href: url)
  end

  def mention(text)
    content_tag(:a, "@#{text}")
  end

  # TODO: improve markup mechanism
  def markup_format(message)
    # Bold
    message.gsub!(/[*](.*?)[*]/) do
      %(<b>#{Regexp.last_match(1)}</b>)
    end

    # Italic
    # message.gsub!(/_(.*?)_/) do
    #   %(<em>#{Regexp.last_match(1)}</em>)
    # end

    # Strike
    message.gsub!(/~(.*?)~/) do
      %(<strike>#{Regexp.last_match(1)}</strike>)
    end

    # Code
    message.gsub(/`(.*?)`/) do
      %(<code>#{Regexp.last_match(1)}</code>)
    end
  end
end
