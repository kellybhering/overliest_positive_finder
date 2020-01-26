# frozen_string_literal: true

module Scraper
  class Base
    attr_reader :config

    def initialize(**config)
      @config = config
    end

    def scrap
      raise NotImplementedError
    end
  end
end