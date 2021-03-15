class DonationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index,:create]
  before_action :move_to_root, only: [:index,:create]
  def index
    @donation_address = DonationAddress.new
  end

  def create
    @donation_address = DonationAddress.new(donation_params)
    if @donation_address.valid?
      pay_item
      @donation_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def donation_params
    params.require(:donation_address).permit(:postal_code, :prefecture, :city, :address_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @donation_address_find =  Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @donation_address_find.price,
      card: donation_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root
    redirect_to root_path if  current_user.id == @donation_address_find.user_id || current_user.id != @donation_address_find.user_id
  end
end
