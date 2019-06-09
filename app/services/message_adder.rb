# frozen_string_literal: true

class MessageAdder
  def self.add(messages, channel)
    messages.each do |message|
      user = User.find_by(slack_id: message["user"])

      unless user
        Rails.logger.info("[HistoryCrawlWorker] There is no User " \
                        "with slack_id = #{message['user']}")
        next
      end

      new_message = user.messages.find_or_initialize_by(message_type: message["type"],
                                                        ts: Time.zone.at(message["ts"].to_d),
                                                        channel: channel)
      new_message.text = message["text"].presence || ""
      new_message.save! if new_message.new_record? || new_message.changed?

      message["reactions"]&.each do |reaction|
        ar_reaction = new_message.reactions.find_or_create_by!(name: reaction["name"])
        ar_reaction.users = User.where(slack_id: reaction["users"])
      end
    end
  end
end
