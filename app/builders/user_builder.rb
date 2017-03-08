class UserBuilder
  def self.from_omniauth!(user_info, uid)
    User.find_or_initialize_by(slack_id: user_info.id) do |user|
      user.provider   = "slack"
      user.uid        = uid
      user.first_name = user_info.profile.first_name
      user.email      = user_info.profile.email
      user.last_name  = user_info.profile.last_name
      user.username   = user_info.name
      user.avatar     = user_info.profile.image_24
      user.password   = Devise.friendly_token[0, 20]
    end
  end

  def self.from_api(member, team_id)
    # TODO: handle bots
    return unless member["profile"]["email"]

    User.find_or_initialize_by(slack_id: member["id"]) do |user|
      user.email      = member["profile"]["email"]
      user.username   = member["name"]
      user.first_name = member["profile"]["first_name"]
      user.last_name  = member["profile"]["last_name"]
      user.avatar     = member["profile"]["image_24"]
      user.password   = Devise.friendly_token[0, 20]
      user.team_id    = team_id
    end
  end
end
