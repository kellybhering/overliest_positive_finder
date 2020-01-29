# frozen_string_literal: true

class OverliestPositiveReviewsFinder
  class << self
    def call(review_site: AVAILABLE_REVIEW_SITES[:dealer_rater])
      scraper = review_site[:scraper][:executor]
      converter = review_site[:converter]
      score_calculator = review_site[:score_calculator]

      reviews_hashes_array = scraper.new(review_site[:scraper][:config]).scrap
      reviews = converter.convert(reviews_hashes_array: reviews_hashes_array)
      reviews_with_score = score_calculator.input_score_to(reviews: reviews, sort_type: :asc)

      print_overliest_positive_reviews(reviews_with_score)
    end

    private

    def print_overliest_positive_reviews(reviews_with_score)
      puts "*** DEALER RATER's 5 \"OVERLIEST\" POSITIVE REVIEW ARE ***\r\n\r\n"
      (0..4).each do |index|
        puts (reviews_with_score[index].to_s + "\r\n\r\n\r\n\r\n\r\n" unless reviews_with_score[index].nil? )
      end
    end
  end
end