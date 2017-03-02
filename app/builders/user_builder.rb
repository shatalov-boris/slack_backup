class UserBuilder
  def self.from_omniauth!(slack_info)
    user_info = slack_info.extra.user_info.user
    User.find_or_create_by!(slack_id: user_info.id) do |user|
      user.team       = Team.find_by(slack_id: slack_info.extra.team_info.team.id)
      user.provider   = "slack"
      user.uid        = slack_info.uid
      user.first_name = user_info.profile.first_name
      user.email      = user_info.profile.email
      user.last_name  = user_info.profile.last_name
      user.username   = user_info.name
      user.avatar     = user_info.profile.image_24
      user.password   = Devise.friendly_token[0, 20]
    end
  end

  def self.from_api(member)
    return unless member["profile"]["email"]
    User.find_or_create_by(slack_id: member["id"]) do |user|
      user.email      = member["profile"]["email"]
      user.username   = member["name"]
      user.first_name = member["profile"]["first_name"]
      user.last_name  = member["profile"]["last_name"]
      user.avatar     = member["profile"]["image_24"]
      user.password   = Devise.friendly_token[0, 20]
    end
  end
end
