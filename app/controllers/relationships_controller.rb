class RelationshipsController < ApplicationController

  def create
    @item = Item.find(params[:relationship][:followed id])
    current user.follow!(@user)
    redirect to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current user.unfollow!(@user)
    redirect to @user
  end
end
