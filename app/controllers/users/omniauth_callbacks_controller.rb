class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    slack_info = request.env["omniauth.auth"]

    team_info = slack_info.extra.team_info.team
    team = Team.find_or_create_by!(slack_id: team_info.id, name: team_info.name)

    @user = UserBuilder.from_omniauth!(slack_info)
    @user.update!(slack_access_token: slack_info.credentials.token)

    if @user.persisted?
      MembersParserWorker.perform_async(team.id, slack_info.credentials.token)
      ChannelParserWorker.perform_async(slack_info.credentials.token)
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Slack") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end
