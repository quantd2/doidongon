class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @items = Item.all.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
