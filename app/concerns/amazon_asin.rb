# frozen_string_literal: true

class AmazonAsin < String
  AMAZON_URL = "https://www.amazon.ca/dp/"

  ############################################################################
  # This Decorator pattern processes the string
  # @raise Exception
  # @param [String] - A valid ASIN string in the format of "BXXXXXXXXX"
  def initialize(asin)
    raise "Invalid ASIN" unless Regexp.new(/^B[\dA-Z]{9}|\d{9}(X|\d)$/).match?(asin)

    super(asin)
  end

  # @return [String] - The full URL of the ASIN
  def to_url
    "#{AMAZON_URL}#{self}"
  end
end
