FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    last_name { '山田' }
    first_name { '太郎' }
    kana_last_name { 'ヤマダ' }
    kana_first_name { 'タロウ' }
    birthday { '1933-02-02' }
  end
end
