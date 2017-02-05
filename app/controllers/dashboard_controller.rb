class DashboardController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.all.paginate(page: params[:page])
  end
end
