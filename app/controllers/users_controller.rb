class UsersController < ApplicationController
  include UsersHelper
  before_action :verify_is_admin, except: [:show]

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
  end

  def show
    @user = current_user
    @items = @user.items.paginate(page: params[:page])
  end

end
