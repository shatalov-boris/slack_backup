# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :message
  has_many :user_reactions
  has_many :users, through: :user_reactions
end
