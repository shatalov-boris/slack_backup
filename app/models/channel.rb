class Channel < ApplicationRecord
  belongs_to :team
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

  scope :with_messages, -> { where.not(messages_count: 0) }
  scope :recent, -> { order(updated_at: :desc) }

  def name(user = nil)
    if direct_message?
      raise "`user` parameter must be present to detect direct message channel name" unless user

      partner(user).name
    elsif group_message?
      users.map(&:name).join(", ")
    else
      super()
    end
  end

  def partner(user)
    raise "`partner` can be only for direct message channel" unless direct_message?
    return user if users_count == 1

    users.to_a.detect { |ch_user| ch_user != user }
  end

  def user_with_access
    return creator if creator&.slack_access_token.present?

    users.detect { |user| user.slack_access_token.present? }
  end

  private

  def set_next_crawl_time
    self.next_crawl_time = Time.current
  end

  def creator
    User.find_by(slack_id: creator_slack_id)
  end
end
