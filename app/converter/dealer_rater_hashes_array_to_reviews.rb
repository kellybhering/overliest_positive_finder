# frozen_string_literal: true

module Converter
  class DealerRaterHashesArrayToReviews
    class << self
      def convert(reviews_hashes_array:)
        reviews_hashes_array.map do |review_hash|
          DTO::Review::DealerRater.new(review_hash)
        end
      end
    end
  end
end
