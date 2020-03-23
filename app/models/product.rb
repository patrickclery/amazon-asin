# frozen_string_literal: true

class Product < ApplicationRecord
  attribute :asin
  attribute :category_name
  attribute :category_url
  attribute :dimensions
  attribute :product_title
  attribute :rank

  validates :asin, presence: true
  validates :category_name, presence: true
  validates :category_url, presence: true
  validates :product_title, presence: true
  validates :rank, presence: true
end
