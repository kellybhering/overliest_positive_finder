# frozen_string_literal: true

require 'faraday'

module Scraper
  class Base
    attr_reader :config

    def initialize(**config)
      @config = config
    end

    def scrap(hash_converter: nil)
      raise NotImplementedError
    end

    private

    # Faraday was used because open() and HTTParty didn't work no this site
    def get_html(url)
      response = Faraday.get(url)
      response.body
    end
  end
end
