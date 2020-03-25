# frozen_string_literal: true
module Api
  module V1
    class ProductSerializer
      include FastJsonapi::ObjectSerializer
      set_key_transform :camel_lower

      attribute :asin
      attribute :category_name
      attribute :category_url
      attribute :dimensions
      attribute :product_title
      attribute :product_url do |product|
        "https://www.amazon.ca/dp/#{product.asin}"
      end
      attribute :rank
    end
  end
end