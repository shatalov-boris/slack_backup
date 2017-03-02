class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  belongs_to :team
end
