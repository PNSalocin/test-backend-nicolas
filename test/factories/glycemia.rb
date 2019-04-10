# frozen_string_literal: true

FactoryBot.define do
  factory :glycemia do
    user
    measurement { Faker::Number.between(700, 2000) }
    taken_at { Faker::Date.between(30.days.ago, Date.today) }
  end
end
