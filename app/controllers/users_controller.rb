class UsersController < ApplicationController
  include UsersHelper
  before_action :verify_is_admin

  def index
    @users = User.all
  end

  def destroy
  end

end
