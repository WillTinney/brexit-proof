require 'faker'

FactoryGirl.define do
  factory :proof do |f|
    f.association :user
    f.user_id { FactoryGirl.build(:user).id }
    f.document { "document" }
    f.title { Faker::Lorem.word }
    f.comments { Faker::Lorem.paragraph }
  end
end
