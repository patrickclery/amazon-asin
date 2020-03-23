# frozen_string_literal: true

class FetchProductData
  # Validates the ASIN and passes it to ExtractDataFromHtml
  # Used as a separate service so EDFH could be tested in isolation
  # @return {Hash} - A response containing the category, rank, and dimensions
  # @param [String] - ASIN
  def self.call(_asin)
    # Format the ASIN and validate it
    asin = AmazonAsin.new(_asin)

    # Bubble this up, let the caller handle it
    raise InvalidAsinError unless asin.valid?

    # Fetch and check for a non-success response
    response = Faraday.get(asin.to_url)
    raise ProductNotFoundError unless response.success?

    ExtractDataFromHtml.call(response.body)
  end

  class InvalidAsinError < StandardError
    def message
      "The ASIN you entered was not a validly-formed ASIN. Please check the spelling."
    end
  end
  class ProductNotFoundError < StandardError
    def message
      "The ASIN you entered was not found on Amazon. Please check the spelling."
    end
  end
end
