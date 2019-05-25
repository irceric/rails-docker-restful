# spec/factories/members.rb

FactoryBot.define do
  factory :member do
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    member_type 'contractor'
    duration 10
  end

end