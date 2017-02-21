class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_item
  respond_to :js

  def new
    set_item
    @items = current_user.items
  end

  def create
    @items = current_user.items
    @follower_item = Item.find(params[:relationship][:follower_id])
    begin
      @follower_item.follow!(@@item)
    rescue Exception => e
      flash[:alert] = 'the item has followed maximum 3 others.'
    end
    redirect_to root_path
  end

  def destroy
    # @user = Relationship.find(params[:id]).followed
    # current user.unfollow!(@user)
    # redirect to @user
  end

  private

  def set_item
    @@item = Item.find(params[:item_id])
  end

end
