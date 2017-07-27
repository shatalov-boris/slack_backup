class User < ApplicationRecord
  extend FriendlyId
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:slack]
  friendly_id :username, use: %i[slugged finders]

  belongs_to :team
  has_many :channel_members
  has_many :channels, through: :channel_members
  has_many :user_reactions
  has_many :reactions, through: :user_reactions
  has_many :messages

  def name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      username
    end
  end
end
