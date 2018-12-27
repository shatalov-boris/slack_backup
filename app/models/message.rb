# frozen_string_literal: true

class Message < ApplicationRecord
  PER_PAGE = 20

  belongs_to :user
  belongs_to :channel, counter_cache: true
  has_many :reactions

  def page_in_channel
    position = channel.messages.where("ts >= ?", ts).count
    (position.to_f / PER_PAGE).ceil
  end
end
