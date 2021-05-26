class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item
  before_action :redirect_to_root
  before_action :sold_item

  def index
    @buy_area = BuyArea.new
  end

  def create
    @buy_area = BuyArea.new(buy_params)
    if @buy_area.valid?
      pay_item
      @buy_area.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def redirect_to_root
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def buy_params
    params.require(:buy_area).permit(:postal_code, :shipping_area_id, :town, :address, :building, :tel).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def sold_item
    buy = Buy.find(params[:item_id])
    if user_signed_in? && @item.id == buy.item_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
  end
end
