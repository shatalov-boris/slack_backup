# frozen_string_literal: true

class HistoryRestorer
  def self.restore(folder)
    channels_json = File.read(folder + "channels.json")
    channels = JSON.parse(channels_json)
    channels.each do |json_channel|
      puts "Restoring #{json_channel['name']}"
      channel = ChannelBuilder.build_from_json(json_channel)
      channel.save! if channel.new_record? || channel.changed?

      Dir.foreach(folder + json_channel["name"]) do |channel_file_name|
        next if (channel_file_name == ".") || (channel_file_name == "..")

        channel_json = File.read(folder + json_channel["name"] + channel_file_name)
        messages = JSON.parse(channel_json)
        MessageAdder.add(messages, channel)
      end
      puts "Restoring for #{json_channel['name']} has finished"
    end
  end
end
