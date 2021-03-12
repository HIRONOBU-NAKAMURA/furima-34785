class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_change
  belongs_to :shipping_address
  belongs_to :day

  with_options presence: true do
    validates :title
    validates :description
    validates :price
    validates :category_id, numericality: { other_than: 1 }
    validates :status_id, numericality: { other_than: 1 }
    validates :shipping_change_id, numericality: { other_than: 1 }
    validates :shipping_address_id, numericality: { other_than: 1 }
    validates :day_id, numericality: { other_than: 1 }
  end
end
