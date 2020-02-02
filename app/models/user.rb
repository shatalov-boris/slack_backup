# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[slack]
  friendly_id :username, use: %i[slugged finders]

  belongs_to :team
  has_many :channel_members, dependent: :destroy
  has_many :channels, through: :channel_members
  has_many :user_reactions, dependent: :destroy
  has_many :reactions, through: :user_reactions
  has_many :messages, dependent: :destroy

  def name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      username
    end
  end
end
