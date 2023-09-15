class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
