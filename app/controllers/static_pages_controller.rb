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
        order(item_search_term.order)
      filtering_params(params).each do |key, value|
        @items = @items.public_send(key, value) if value.present?
      end
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

  private

  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params[:item].slice(:location_filter, :category_filter)
  end
end
