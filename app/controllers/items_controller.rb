class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :find_item, only: [:show, :edit, :update]
  before_action :edit_item, only: [:edit, :update]


  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :delivery_charge_id, :area_id, :day_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def edit_item
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
