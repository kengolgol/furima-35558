class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  #before_action :redirect_to_root, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @buy_area = BuyArea.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buy_area = BuyArea.new(buy_params)
    if @buy_area.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
      @buy_area.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def redirect_to_root
    if current_user.id
      redirect_to root_path
    end
  end

  def buy_params
    params.require(:buy_area).permit(:postal_code, :shipping_area_id, :town, :address, :building, :tel).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
end
