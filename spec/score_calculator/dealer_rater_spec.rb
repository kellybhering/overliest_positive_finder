# frozen_string_literal: true

require 'spec_helper'

describe ScoreCalculator::DealerRater do
  describe '.input_score_to' do
    subject(:input_score) { described_class.input_score_to(reviews: reviews, sort_type: sort_type) }

    let(:sort_type) { nil }

    let(:reviews) { [DTO::Review::DealerRater.new(dealer_rater_review_hash)] }

    let(:dealer_rater_review_hash) do
      {
        date: 'January 16, 2020',
        title: title,
        text: text,
        number_of_employees_worked_with: 2,
        has_photo: true,
        rating: rating,
        detailed_rating: detailed_rating
      }
    end
    let(:rating) { 0 }
    let(:detailed_rating) { {} }
    let(:title) { '' }
    let(:text) { '' }

    let(:review_score) { input_score[0].score }

    context 'with a review matching no rule for overly positive score' do
      it 'should score 100' do
        expect(review_score).to eq(100)
      end
    end

    context 'with a review matching every rule for overly positive score' do
      let(:rating) { 50 }
      let(:detailed_rating) do
        {
          customer_service: 50,
          quality_of_work: 50,
          friendliness: 50,
          pricing: 50,
          overall_experience: 50
        }
      end
      let(:title) { 'Best and great place to buy a car' }
      let(:text) { 'Thank lord, this place is a miracle. It has the greatest salesmen' }

      it 'should score 65' do
        expect(review_score).to eq(65)
      end
    end

    context 'with a review matching the rating rule for overly positive score' do
      let(:rating) { 50 }

      it 'should score 90' do
        expect(review_score).to eq(90)
      end
    end

    context 'with a review matching the detailed rating rule for overly positive score' do
      context 'with every rating filled' do
        let(:detailed_rating) do
          {
            customer_service: 50,
            quality_of_work: 50,
            friendliness: 50,
            pricing: 50,
            overall_experience: 50
          }
        end

        it 'should score 91' do
          expect(review_score).to eq(91)
        end
      end

      context 'with only overall experience rating filled' do
        let(:detailed_rating) do
          {
            customer_service: 0,
            quality_of_work: 0,
            friendliness: 0,
            pricing: 0,
            overall_experience: 50
          }
        end

        it 'should score 91' do
          expect(review_score).to eq(91)
        end
      end
    end

    context 'with a review matching the title rule for overly positive score' do
      context 'with a single weight 2 regex' do
        let(:title) { 'The best' }

        it 'should score 98' do
          expect(review_score).to eq(98)
        end
      end

      context 'with two weight 2 regexes' do
        let(:title) { 'The best and great' }

        it 'should score 96' do
          expect(review_score).to eq(96)
        end
      end

      context 'with two weight 2 and one weight 4 regexes' do
        let(:title) { 'The best and great. Best best place to bye a car' }

        it 'should score 92' do
          expect(review_score).to eq(92)
        end
      end
    end

    context 'with a review matching the text rule for overly positive score' do
      context 'with a single weight 2 regex' do
        let(:text) { 'Thanks lord!' }

        it 'should score 98' do
          expect(review_score).to eq(98)
        end
      end

      context 'with two weight 2 regexes' do
        let(:text) { 'Thanks lord! This is a miracle' }

        it 'should score 96' do
          expect(review_score).to eq(96)
        end
      end

      context 'with two weight 2 and one weight 4 regexes' do
        let(:text) { 'Thanks lord! This is a miracle. They have the nicest top ever salesman' }

        it 'should score 92' do
          expect(review_score).to eq(92)
        end
      end
    end

    context 'with sort' do
      let(:review_hash_91) do
        dealer_rater_review_hash.merge(
          detailed_rating: {
            customer_service: 50,
            quality_of_work: 50,
            friendliness: 50,
            pricing: 50,
            overall_experience: 50
          }
        )
      end

      let(:review_hash_96) do
        dealer_rater_review_hash.merge(
          title: 'The best and great'
        )
      end

      let(:review_score_91) { DTO::Review::DealerRater.new(review_hash_91) }
      let(:review_score_96) { DTO::Review::DealerRater.new(review_hash_96) }

      context 'when ascending' do
        let(:sort_type) { :asc }
        let(:reviews) { [review_score_96, review_score_91] }

        it 'should return an array with score ascending order' do
          expect(input_score.map(&:score)).to eq([91, 96])
        end
      end

      context 'when descending' do
        let(:sort_type) { :desc }
        let(:reviews) { [review_score_96, review_score_91] }

        it 'should return an array with score descending order' do
          expect(input_score.map(&:score)).to eq([96, 91])
        end
      end

      context 'when none' do
        let(:reviews) { [review_score_91, review_score_96] }

        it 'should return the same order' do
          expect(input_score.map(&:score)).to eq([91, 96])
        end
      end
    end
  end
end
