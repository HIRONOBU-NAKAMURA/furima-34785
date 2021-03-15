FactoryBot.define do
  factory :donation_address do
    postal_code { '123-4567' }
    prefecture { 2 }
    city { '葛飾区' }
    address_number { '奥戸7-24-7' }
    building_name { 'マンション' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
