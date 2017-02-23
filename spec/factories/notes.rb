require 'faker'

FactoryGirl.define do
  factory :note do |p|
    p.user_id { FactoryGirl.build(:user).id }
    p.title { "document" }
    p.content { Faker::Lorem.word }
  end
end
