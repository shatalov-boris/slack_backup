class AuthenticatedUserController
  before_action :authenticate_user!
end
