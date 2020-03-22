# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController

      def index
        @products = Product.all

        render json: ProductSerializer.new(@products)
      end

      def create
        attributes = FetchProductData.call(product_params[:asin])
        product = Product.new(attributes)

        if product.save
          render json: ProductSerializer.new(product), status: :created
        else
          render json: ProductSerializer.new(product).errors, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.permit(:asin)
      end
    end

  end
end