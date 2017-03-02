class User < ApplicationRecord
  extend FriendlyId
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:slack]
  friendly_id :username, use: [:slugged, :finders]

  belongs_to :team
  has_many :channel_members
  has_many :channels, through: :channel_members
  has_many :messages
end
