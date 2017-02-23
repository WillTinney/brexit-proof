require 'faker'
require 'nationality'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.free_email }
    f.password { "password" }

    trait :with_details do
      title { ['Mr', 'Mrs', 'Ms'].sample }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      citizenship { Nationality::NATIONALITY }
      date_of_birth { Faker::Date.between(25.years.ago, 50.years.ago) }
      phone_number { '07' + ('%09d' % rand(10 ** 9)).to_s }
      address_line_1 { Faker::Address.street_address }
      address_line_2 { Faker::Address.secondary_address }
      city { Faker::Address.city }
      country { Faker::Address.country_code }
      postcode { Faker::Address.postcode }
    end

    trait :number_of_children do
      number_of_children { rand(0..5) }
    end

    trait :number_of_guardians do
      number_of_guardians { rand(0..5) }
    end

    trait :data_unlocked do
      data_unlocked { false }
    end
  end
end
