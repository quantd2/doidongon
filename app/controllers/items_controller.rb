class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]

  # GET /items
  # GET /items.json
  # def index
  #   @items = current_user.items.all
  # end

  # GET /items/1
  # GET /items/1.json
  # def show
  # end

  # GET /items/new
  def new
    @item = current_user.items.new
    @locations =  Location.all
    @categories = Category.all
  end

  # GET /items/1/edit
  def edit
    @locations =  Location.all
    @categories = Category.all
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(item_params)
    #@locations =  Location.find(item_params.location_attributes)
    respond_to do |format|
      if @item.save
        set_image
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        set_image
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Items.find(params[:id])
    end

    def set_image
      if params[:images]
        #===== The magic is here ;)
        params[:images].each { |image|
          @item.item_images.create(image: image)
        }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_id, :name, :description, :location_id, :category_id)
    end
end
