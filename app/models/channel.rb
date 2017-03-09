class Channel < ApplicationRecord
  has_many :channel_members
  has_many :users, through: :channel_members
  has_many :messages
  has_many :reactions

  after_initialize :set_next_crawl_time, unless: :next_crawl_time

  enum status: {
    opened: 0,
    archived: 1
  }

  enum channel_type: {
    public_channel: 0,
    private_channel: 1,
    direct_message: 2,
    group_message: 3
  }

  def user_with_access
    creator&.slack_access_token.blank? ? users.where.not(slack_access_token: "").first : creator
  end

  private

  def set_next_crawl_time
    self.next_crawl_time = DateTime.current
  end

  def creator
    User.find_by(slack_id: creator_slack_id)
  end
end
