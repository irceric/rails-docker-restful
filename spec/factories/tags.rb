# spec/factories/tags.rb

FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }
    member_id nil
  end

end