class FollowItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @items = current_user.items.all
    @follow_item = FollowItem.new
    #render "my_items"
  end

  def create
    @items = current_user.items.all
    @follow_item = FollowItem.create(follow_item_params)
    respond_to do |format|
      if @follow_item.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @follow_item.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private

  def follow_item_params
    params.require(:current_user).permit({})
  end

end
