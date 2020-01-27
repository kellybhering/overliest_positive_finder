# frozen_string_literal: true

module Scraper
  class DealerRater < Base
    def scrap(hash_converter: Converter::HtmlToDealerRaterHash.new)
      hash_converter.add(get_html)
    end

    private

    def url(page_number: 1)
      dealer_title = @config[:dealer_title]
      dealer_page_code = @config[:dealer_page_code]

      "https://www.dealerrater.com/dealer/#{dealer_title}-dealer-reviews-#{dealer_page_code}/page#{page_number}/?filter=ALL_REVIEWS#link"
    end
  end
end