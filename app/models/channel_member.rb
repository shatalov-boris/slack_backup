# frozen_string_literal: true

class ChannelMember < ApplicationRecord
  belongs_to :user
  belongs_to :channel, counter_cache: :users_count
end
