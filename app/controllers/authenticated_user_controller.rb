# frozen_string_literal: true

class AuthenticatedUserController
  before_action :authenticate_user!
end
