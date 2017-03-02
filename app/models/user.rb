class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  belongs_to :team
end
