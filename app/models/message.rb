class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  has_many :reactions
end
