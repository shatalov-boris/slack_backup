class UserBuilder
  def self.build!(user_info, uid)
    User.find_or_create_by(provider: "slack", uid: uid) do |user|
      user.slack_id = user_info.id
      user.first_name = user_info.profile.first_name
      user.email = user_info.profile.email
      user.last_name = user_info.profile.last_name
      user.username = user_info.name
      user.avatar = user_info.profile.image_24
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
