# frozen_string_literal: true

class FetchAsinData
  class << self
    # @return {Hash} - A response containing the category, rank, and dimensions
    # @param [AmazonAsin] - A valid ASIN object
    def call(asin)
      response = Faraday.get(asin.to_url)
      ExtractAmazonData.call(response.body)
    end
  end
end
