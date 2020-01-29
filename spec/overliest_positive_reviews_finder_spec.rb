# frozen_string_literal: true

require 'spec_helper'

describe OverliestPositiveReviewsFinder do
  describe '.call' do
    subject(:print_reviews) { described_class.call }

    context 'with default configuration' do
      before do
        allow_any_instance_of(Scraper::DealerRater).to receive(:scrap).and_return([dealer_rater_hashes_array])

        allow(Converter::DealerRaterHashesArrayToReviews).to receive(:convert)
          .with(reviews_hashes_array: [dealer_rater_hashes_array]).and_return([dealer_rater_reviews_array])

        allow(ScoreCalculator::DealerRater).to receive(:input_score_to)
          .with(reviews: [dealer_rater_reviews_array], sort_type: :asc).and_return([dealer_rater_reviews_with_score_array])

        allow_any_instance_of(DTO::Review::DealerRater).to receive(:to_s).and_return('')

        allow($stdout).to receive(:write)
      end

      let(:dealer_rater_hashes_array) do
        {
          date: 'January 16, 2020',
          title: 'Title 1',
          text: 'Text 1',
          number_of_employees_worked_with: 2,
          has_photo: true,
          rating: 49,
          detailed_rating: {
            customer_service: 49,
            quality_of_work: 10,
            friendliness: 20,
            pricing: 30,
            overall_experience: 40
          }
        }
      end

      let(:dealer_rater_reviews_array) { DTO::Review::DealerRater.new(dealer_rater_hashes_array) }
      let(:dealer_rater_reviews_with_score_array) do
        reviews_with_score = dealer_rater_reviews_array.clone
        reviews_with_score.score = 20
        reviews_with_score
      end

      it 'should call the scraper' do
        expect_any_instance_of(Scraper::DealerRater).to receive(:scrap).once
        print_reviews
      end

      it 'shoud call the review converter' do
        expect(Converter::DealerRaterHashesArrayToReviews).to receive(:convert)
          .with(reviews_hashes_array: [dealer_rater_hashes_array]).once
        print_reviews
      end

      it 'should call the score calculator with ascending sorting order' do
        expect(ScoreCalculator::DealerRater).to receive(:input_score_to)
          .with(reviews: [dealer_rater_reviews_array], sort_type: :asc).once
        print_reviews
      end

      it 'should print the reviews' do
        expect_any_instance_of(DTO::Review::DealerRater).to receive(:to_s).once
        print_reviews
      end
    end
  end
end
