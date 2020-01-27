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

    def get_html(url)
      #TODO: Error handling
      response = Faraday.get(url)
      response.body
    end
  end
end