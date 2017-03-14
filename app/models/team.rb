class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :channels
end
