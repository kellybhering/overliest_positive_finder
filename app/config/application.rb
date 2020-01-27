#TODO: improve file requirement
require './app/scraper/base'
require './app/scraper/dealer_rater'
require './app/converter/html_to_dealer_rater_hash'
require './app/converter/dealer_rater_hashes_array_to_reviews'
require './app/score_calculator/dealer_rater'
require './app/dto/review/base'
require './app/dto/review/dealer_rater'
require './overliest_positive_reviews_finder'

AVAILABLE_REVIEW_SITES = {
  dealer_rater: {
      scraper: {
        config: {
          dealer_title: 'McKaig-Chevrolet-Buick-A-Dealer-For-The-People',
          dealer_page_code: 23685,
          number_of_pages_to_scrap: 5
        },
        executor: Scraper::DealerRater
      },
      converter: Converter::DealerRaterHashesArrayToReviews,
      score_calculator: ScoreCalculator::DealerRater
  }
}
