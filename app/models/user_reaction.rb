# frozen_string_literal: true

class UserReaction < ApplicationRecord
  belongs_to :user
  belongs_to :reaction, counter_cache: :users_count
end
