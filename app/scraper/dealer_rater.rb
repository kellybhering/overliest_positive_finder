# frozen_string_literal: true

module Scraper
  class DealerRater < Base
    def scrap(hash_converter: Converter::HtmlToDealerRaterHash.new)
      number_of_pages = @config[:number_of_pages_to_scrap]

      (1..number_of_pages).each do |page_number|
        html = get_html(url(page_number: page_number))
        hash_converter.add(html)
      end

      hash_converter.reviews
    end

    private

    def url(page_number: 1)
      "https://www.dealerrater.com/dealer/#{dealer_title}-dealer-reviews-#{dealer_page_code}/page#{page_number}/?filter=ALL_REVIEWS#link"
    end

    def dealer_title
      @dealer_title ||= @config[:dealer_title]
    end

    def dealer_page_code
      @dealer_page_code ||= @config[:dealer_page_code]
    end
  end
end
