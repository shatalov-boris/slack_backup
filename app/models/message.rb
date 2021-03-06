# frozen_string_literal: true

class Message < ApplicationRecord
  PER_PAGE = 20

  belongs_to :user
  belongs_to :channel
  has_many :reactions, dependent: :destroy

  counter_culture :channel

  def page_in_channel
    position = channel.messages.where("ts >= ?", ts).count
    (position.to_f / PER_PAGE).ceil
  end
end
