class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_change
  belongs_to :shipping_address
  belongs_to :day

  VALID_PRICEL_HALF = /\A[0-9]+\z/

  with_options presence: true do
    validates :title
    validates :image
    validates :description
    validates :price, format: { with: VALID_PRICEL_HALF }, numericality: { only_integer: true,
                                                                           greater_than: 300, less_than: 10_000_000 }
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_change_id
    validates :shipping_address_id
    validates :day_id
  end
end
