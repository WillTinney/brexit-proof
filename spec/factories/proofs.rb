require 'faker'

FactoryGirl.define do
  factory :proof do |p|
    p.user_id { FactoryGirl.build(:user).id }
    p.document { "document" }
    p.comments { Faker::Lorem.paragraph }
  end
end
