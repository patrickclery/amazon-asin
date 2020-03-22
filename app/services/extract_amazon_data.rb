# frozen_string_literal: true

class ExtractAmazonData
  class << self
    # @raise Exception
    # @return {Hash} - A response containing the category, rank, and dimensions
    # @param [String] - The HTML content of an Amazon product page
    def call(html)
      @parser = Nokogiri.HTML(html)

      data                 = {}
      data[:category_name] = extract_category_name
      data[:category_url]  = extract_category_url
      data[:dimensions]    = extract_dimensions
      data[:rank]          = extract_rank

      data
    end

    private

    # @return [String] - Category name from breadcrumbs
    def extract_category_name
      @parser.css("#showing-breadcrumbs_div//span/a")
             .map(&:inner_html)
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
             .inner_html
             .gsub(/#(\d)/, '\1')
    end

    # @return [String] - Dimensions (if available)
    def extract_dimensions
      @parser.xpath("//tr[@class='size-weight'][td[contains(text(), 'Product Dimensions')]]/td[@class='value']")
             .inner_html
             .strip
             .then { |str| CGI.unescape_html(str) }
    end
  end
end
