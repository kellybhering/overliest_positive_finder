# frozen_string_literal: true

module ScoreCalculator
  class DealerRater
    class << self
      def input_score_to(reviews:, sort_type: nil)
        reviews_with_score = reviews.map do |review|
          review_clone = review.clone
          review_clone.score = calculate_score(review_clone)
          review_clone
        end

        sort(reviews_with_score, sort_type)
      end
    
      private
    
      def calculate_score(review)
        @review = review
        score = 100
        score -= 10 if max_rating?
        score -= 9 if detailed_rating_with_max_rating? || detailed_rating_overall_only_and_max_rating?
        
        overly_positive_matches_in_title.each { |matching| score -= matching[:weight] }
        
        overly_positive_matches_in_text.each { |matching| score -= matching[:weight] }

        score
      end

      def max_rating?
        @review.rating == 50
      end

      def detailed_rating_with_max_rating?
        max_rating = {
          customer_service: 50,
          quality_of_work: 50,
          friendliness: 50,
          pricing: 50,
          overall_experience: 50
        }

        @review.detailed_rating.eql?(max_rating)
      end

      def detailed_rating_overall_only_and_max_rating?
        overall_max_rating_only = {
          customer_service: 0,
          quality_of_work: 0,
          friendliness: 0,
          pricing: 0,
          overall_experience: 50
        }
        
        @review.detailed_rating.eql?(overall_max_rating_only)
      end

      def overly_positive_matches_in_title
        overly_positive_matches_for_title = [
          { regex: /best/, weight: 2 },
          { regex: /great/, weight: 2 },
          { regex: /(?=.*best)(?=.*place)(?=.*(car|vehicle))/, weight: 4 }
        ]

        overly_positive_matches_for_title.map do |matching|
          matching if @review.title.downcase.match(matching[:regex])
        end.compact
      end

      def overly_positive_matches_in_text
        overly_positive_matches_for_text = [
          { regex: /lord/, weight: 2 },
          { regex: /miracle/, weight: 2 },
          { regex: /(?=.*(greatest|nicest|best))(?=.*(salesmen|salesman|saleswoman|sellers|salespeople))/, weight: 4 }
        ]

        overly_positive_matches_for_text.map do |matching|
          matching if @review.text.downcase.match(matching[:regex])
        end.compact
      end

      def sort(reviews_with_score, type)
        return reviews_with_score.sort_by{ |obj| obj.score } if type == :asc
        return reviews_with_score.sort_by{ |obj| obj.score }.reverse if type == :desc
        reviews_with_score
      end
    end
  end
end