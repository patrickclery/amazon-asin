# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    asin { Faker::Code.asin }
    category_name { Faker::Commerce.product_name }
    category_url { Faker::Internet.url }
    dimensions { "#{Faker::Measurement.height} x #{Faker::Measurement.height} x #{Faker::Measurement.height} cm" }
    rank { rand(1..100) }
  end
end
