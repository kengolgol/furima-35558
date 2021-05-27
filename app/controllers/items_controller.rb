class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :sold_item, only: [:edit, :update, :destroy]
  before_action :redirect_to_root, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :delivery_charge_id, :shipping_area_id, :day_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def redirect_to_root
    unless (current_user.id == @item.user_id) || (@item.id != @item.buy.item_id)
      redirect_to root_path
    end
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def sold_item
    if @item.buy != nil
      if user_signed_in? && (@item.id == params[:id].to_i)
        redirect_to root_path
      end
    end
  end
end
