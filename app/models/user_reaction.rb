# frozen_string_literal: true

class UserReaction < ApplicationRecord
  belongs_to :user
  belongs_to :reaction

  counter_culture :reaction, column_name: :users_count
end
