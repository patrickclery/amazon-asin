# frozen_string_literal: true

class FetchProductData
  class << self
    # Validates the ASIN and passes it to ExtractDataFromHtml
    # Used as a separate service so EDFH could be tested in isolation
    # @return {Hash} - A response containing the category, rank, and dimensions
    # @param [String] - ASIN
    def call(_asin)

      # Format the ASIN and validate it
      asin = AmazonAsin.new(_asin)
      raise "Invalid ASIN" unless asin.valid?

      # Fetch and extract the data
      response = Faraday.get(asin.to_url)
      ExtractDataFromHtml.call(response.body)
    end
  end
end
