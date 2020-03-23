# frozen_string_literal: true

class ExtractDataFromHtml
  class << self
    # @raise Exception
    # @return {Hash} - A response containing the category, rank, and dimensions
    # @param [String] - The HTML content of an Amazon product page
    def call(html)
      @parser = Nokogiri.HTML(html)

      data                 = {}
      data[:asin]          = extract_asin
      data[:product_title] = extract_product_title
      data[:category_name] = extract_category_name
      data[:category_url]  = extract_category_url
      data[:dimensions]    = extract_dimensions
      data[:rank]          = extract_rank

      data
    end

    private

    # @return [String] - ASIN Product Identifier
    def extract_asin
      value = @parser.xpath("//tr[td[contains(text(), 'ASIN')]]/td[@class='value']")
                     .text

      return value if value.present?

      @parser.xpath("//li[b[contains(text(), 'ASIN:')]][1]")
             .text
             .sub("ASIN: ", "")
             .strip
    end

    # @return [String] - Product Title
    def extract_product_title
      @parser.css("#productTitle").text.strip
    end

    # @return [String] - Category name from breadcrumbs
    def extract_category_name
      @parser.css("#showing-breadcrumbs_div//span/a")
             .map(&:text)
             .map(&:strip)
             .map { |text| CGI.unescape_html(text) }
             .join(" > ")
    end

    # @return [String] - Category URL from breadcrumbs
    def extract_category_url
      @parser.css("#showing-breadcrumbs_div//span.a-list-item/a")
             .last["href"]
             .gsub(/.*node=(\d+)$/, 'https://www.amazon.ca/b/?node=\1')
    end

    # @return [String] - Rank in current category
    def extract_rank
      @parser.css("#SalesRank//span.zg_hrsr_rank")
             .text
             .strip
             .gsub(/#(\d)/, '\1')
    end

    # @return [String] - Dimensions (if available)
    def extract_dimensions
      value = @parser.xpath("//tr[td[contains(text(), 'Product Dimensions')]]/td[@class='value']")
                     .text
                     .strip

      return value if value.present?

      @parser.xpath("//li[b[contains(text(), 'Product Dimensions:')]][1]")
             .text
             .sub("Product Dimensions: ", "")
             .strip
    end
  end
end
