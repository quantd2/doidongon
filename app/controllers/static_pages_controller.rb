class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  # def home
  #   @items = Item.all.paginate(page: params[:page])
  # end

  def home
    if params[:keywords].present?
      @keywords = params[:keywords]
      item_search_term = ItemSearchTerm.new(@keywords)
      @items = Item.where(
        item_search_term.where_clause,
        item_search_term.where_args).
        order(item_search_term.order).paginate(page: params[:page])
    else
      @items = []
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
