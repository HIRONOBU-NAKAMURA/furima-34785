FactoryBot.define do
  factory :item do
    title { Faker::Name.last_name }
    description { Faker::Lorem.sentence }
    category_id { 3 }
    status_id { 3 }
    shipping_change_id { 3 }
    shipping_address_id { 3 }
    day_id { 3 }
    price { 7_777_777 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
