# frozen_string_literal: true

class ChannelMember < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  counter_culture :channel, column_name: :users_count
end
