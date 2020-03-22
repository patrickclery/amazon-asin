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
      attribute :rank
    end
  end
end