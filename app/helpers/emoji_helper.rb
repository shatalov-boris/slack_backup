module EmojiHelper
  def emojify(content)
    return unless content.present?
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      emoji_name = Regexp.last_match(1)
      if emoji = Emoji.find_by_alias(emoji_name)
        %(<img alt="#{emoji_name}" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe
  end
end
