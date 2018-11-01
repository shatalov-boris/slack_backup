class Message < ApplicationRecord
  PER_PAGE = 20

  belongs_to :user
  belongs_to :channel, counter_cache: true
  has_many :reactions
end
