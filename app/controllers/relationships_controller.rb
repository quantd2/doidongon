class RelationshipsController < ApplicationController
  before_action :set_item

  def create
    @items = current_user.items
    @followed_item = Item.find(params[:relationship][:followed_id])
    @item.follow!(@followed_item)
    redirect_to root_path
  end

  def destroy
    # @user = Relationship.find(params[:id]).followed
    # current user.unfollow!(@user)
    # redirect to @user
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
