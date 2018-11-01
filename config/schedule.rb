# frozen_string_literal: true

every 1.day do
  rake "slack_backup:channels_parse"
end

every 1.day do
  rake "slack_backup:members_parse"
end

every 10.minutes do
  rake "slack_backup:history_parse"
end
