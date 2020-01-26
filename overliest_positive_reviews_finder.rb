# frozen_string_literal: true
#TODO apagar este require do byebug
require 'byebug'

class OverliestPositiveReviewsFinder
  class << self
    def call(review_site: AVAILABLE_REVIEW_SITES[:dealer_rater])
      scraper = review_site[:scraper][:executor]
      converter = review_site[:converter]
      score_calculator = review_site[:score_calculator]

      scraper_hash = scraper.new(review_site[:scraper][:config]).scrap
      reviews = converter.convert(hash: scraper_hash)
      reviews_with_score = score_calculator.input_score_to(reviews: reviews)

      #TODO apagar este código
      'teste'
  
    end
  end
end