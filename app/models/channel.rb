class Channel < ApplicationRecord
  has_many :channel_members
  has_many :users, through: :channel_members
  has_many :messages

  enum status: {
    opened: 0,
    archived: 1
  }

  enum channel_type: {
    public: 0,
    private: 1,
    direct_message: 2
  }
end
