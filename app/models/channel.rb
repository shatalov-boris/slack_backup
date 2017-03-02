class Channel < ApplicationRecord
  has_many :channel_members
  has_many :users, through: :channel_members
end
