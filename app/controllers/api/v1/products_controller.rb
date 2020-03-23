# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController

      rescue_from StandardError, with: :error_handler
      rescue_from FetchProductData::InvalidAsinError, with: :error_handler
      rescue_from FetchProductData::ProductNotFoundError, with: :error_handler

      def index
        @products = Product.order(created_at: :desc).all

        render json: ProductSerializer.new(@products)
      end

      def create
        attributes = FetchProductData.call(product_params[:asin])
        product    = Product.new(attributes)

        if product.save
          render json: ProductSerializer.new(product), status: :created
        else
          raise StandardError.new("Sorry, an unknown error occurred! Please refresh this page and try again.")
        end
      end

      private

      def product_params
        params.permit(:asin)
      end

      def error_handler(exception)
        render json:   { errors: [{ detail: exception.message }] },
               status: :unprocessable_entity
      end

    end
  end
end
