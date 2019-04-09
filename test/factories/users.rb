# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { User.genders.to_a.sample[1] }
    age { Faker::Number.between(16, 99) }
  end
end
