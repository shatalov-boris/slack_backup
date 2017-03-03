class UserReaction < ApplicationRecord
  belongs_to :user
  belongs_to :reaction
end
