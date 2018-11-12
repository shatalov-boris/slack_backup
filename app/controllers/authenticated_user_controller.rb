# frozen_string_literal: true

class AuthenticatedUserController < ApplicationController
  before_action :authenticate_user!
end
