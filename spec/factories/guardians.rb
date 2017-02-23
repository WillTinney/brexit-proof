require 'faker'
require 'nationality'

relationship_array = [ 'Friend', 'Family' ]
FactoryGirl.define do
  factory :guardian do |f|
    f.type { 'Guardian' }
    f.title { ['Mr', 'Mrs', 'Ms'].sample }
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.citizenship { Nationality::NATIONALITY }
    f.relationship { relationship_array[rand(0..1)] }
    f.date_of_birth { Faker::Date.between(1.years.ago, 20.years.ago) }
    f.email { Faker::Internet.free_email f.}
    f.phone_number { '07' + ('%09d' % rand(10 ** 9)).to_s }
    f.address_line_1 { Faker::Address.street_address }
    f.address_line_2 { Faker::Address.secondary_address }
    f.city { Faker::Address.city }
    f.country { Faker::Address.country_code }
    f.postcode { Faker::Address.postcode }

    trait :child do
      relationship { 'Child '}
    end

    trait :partner do
      relationship { 'Partner' }
      date_of_birth { Faker::Date.between(25.years.ago, 50.years.ago) }
    end
  end
end
