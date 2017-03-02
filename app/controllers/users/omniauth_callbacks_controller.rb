class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    slack_info = request.env["omniauth.auth"]

    team_info = slack_info.extra.team_info.team
    team = Team.find_or_create_by!(slack_id: team_info.id, name: team_info.name)

    user_info = slack_info.extra.user_info.user
    @user = UserBuilder.build!(user_info, slack_info.uid)
    @user.update!(team: team, slack_access_token: slack_info.credentials.token)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Slack") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end
