class DonationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  def index
    @donation_address = DonationAddress.new
    @donation_address_find =  Item.find(params[:item_id])
    redirect_to root_path if  current_user.id == @donation_address_find.user_id
  end

  def create
    @donation_address = DonationAddress.new(donation_params)
    @donation_address_find = Item.find(params[:item_id])
    if @donation_address.valid?
      pay_item
      @donation_address.save
      redirect_to root_path
    else
      @donation_address_find = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def donation_params
    params.require(:donation_address).permit(:postal_code, :prefecture, :city, :address_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @donation_address_find.price,
      card: donation_params[:token],
      currency: 'jpy'
    )
  end
end
