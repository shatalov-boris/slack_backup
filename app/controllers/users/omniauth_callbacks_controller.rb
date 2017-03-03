class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    slack_info = request.env["omniauth.auth"]

    team_info = slack_info.extra.team_info.team
    team = Team.find_or_create_by!(slack_id: team_info.id, name: team_info.name)

    user_info = slack_info.extra.user_info.user
    @user = UserBuilder.from_omniauth!(user_info, slack_info.uid)
    @user.slack_access_token = slack_info.credentials.token
    @user.team_id = team.id
    @user.save!

    if @user.persisted?
      MembersParser.parse_all(team, slack_info.credentials.token)
      ChannelsParser.parse_all(slack_info.credentials.token)
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Slack") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end
