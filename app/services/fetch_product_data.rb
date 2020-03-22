# frozen_string_literal: true

class FetchProductData
  class << self
    # @return {Hash} - A response containing the category, rank, and dimensions
    # @param [String] - ASIN
    def call(_asin)

      # Format the ASIN and validate it
      asin = AmazonAsin.new(_asin)
      raise "Invalid ASIN" unless asin.valid?

      # Fetch and extract the data
      response = Faraday.get(asin.to_url)
      extracted_data = ExtractProductData.call(response.body)

      # Return a hash including the ASIN
      attributes = { asin: asin.to_s }
      attributes.merge(extracted_data)
    end
  end
end
