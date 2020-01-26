#TODO: improve file requirement
require './app/scraper/base'
require './app/scraper/dealer_rater'
require './app/converter/dealer_rater_hash_to_reviews'
require './app/score_calculator/dealer_rater'
require './app/dto/review/base'
require './app/dto/review/dealer_rater'
require './overliest_positive_reviews_finder'

AVAILABLE_REVIEW_SITES = {
  dealer_rater: {
      scraper: {
        config: { dealer_title: 'McKaig-Chevrolet-Buick-A-Dealer-For-The-People', dealer_page_code: 23685 },
        executor: Scraper::DealerRater
      },
      converter: Converter::DealerRaterHashToReviews,
      score_calculator: ScoreCalculator::DealerRater
  }
}

OverliestPositiveReviewsFinder.call