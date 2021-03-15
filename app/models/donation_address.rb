class DonationAddress
  include ActiveModel::Model
  extend ActiveHash::Associations::ActiveRecordExtensions
  attr_accessor :postal_code, :shipping_address, :city, :address_number, :building_name, :phone_number, :user_id, :item_id,
                :prefecture, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :address_number
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, numericality: { only_integer: true }, length: { maximum: 11 }
    validates :token
    validates :user_id
    validates :item_id
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }

  def save
    # ユーザーとアイテム情報を保存し、donationに代入
    donation = Donation.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    Address.create(postal_code: postal_code, prefecture_id: prefecture, city: city, address_number: address_number,
                   building_name: building_name, phone_number: phone_number, donation_id: donation.id)
  end
end
