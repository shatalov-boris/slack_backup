class Reaction < ApplicationRecord
  belongs_to :message, counter_cache: true
  has_many :user_reactions
  has_many :users, through: :user_reactions
end
