class Channel < ApplicationRecord
  has_many :channel_members
  has_many :users, through: :channel_members
  has_many :messages

  enum status: {
    opened: 0,
    archived: 1
  }

  enum channel_type: {
    public_channel: 0,
    private_channel: 1,
    direct_message: 2
  }
end
