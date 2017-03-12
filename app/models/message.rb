class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel, counter_cache: true
  has_many :reactions
end
