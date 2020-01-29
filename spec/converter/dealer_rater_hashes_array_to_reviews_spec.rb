# frozen_string_literal: true

require 'spec_helper'

describe Converter::DealerRaterHashesArrayToReviews do
  describe '.convert' do
    subject(:convert_to_reviews) { described_class.convert(reviews_hashes_array: dealer_rater_hashes_array) }

    let(:dealer_rater_hashes_array) do
      [{
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
      }, {
        date: 'January 17, 2020',
        title: 'Title 2',
        text: 'Text 2',
        number_of_employees_worked_with: 3,
        has_photo: false,
        rating: 50,
        detailed_rating: {
          customer_service: 50,
          quality_of_work: 20,
          friendliness: 30,
          pricing: 40,
          overall_experience: 50
        }
      }]
    end

    it 'should return an array with two reviews' do
      expect(convert_to_reviews.size).to eq(2)
    end

    it 'a review should contain a data' do
      expect(convert_to_reviews[0].date).to eq('January 16, 2020')
    end

    it 'a review should contain a title' do
      expect(convert_to_reviews[0].title).to eq('Title 1')
    end

    it 'a review should contain a text' do
      expect(convert_to_reviews[0].text).to eq('Text 1')
    end

    it 'a review should contain the number of employees worked with' do
      expect(convert_to_reviews[0].number_of_employees_worked_with).to eq(2)
    end

    it 'a review should inform if a photo was included' do
      expect(convert_to_reviews[0].has_photo).to eq(true)
    end

    it 'a review should contain a rating' do
      expect(convert_to_reviews[0].rating).to eq(49)
    end

    it 'a review should contain a detailed rating' do
      detailed_rating = {
        customer_service: 49,
        quality_of_work: 10,
        friendliness: 20,
        pricing: 30,
        overall_experience: 40
      }

      expect(convert_to_reviews[0].detailed_rating).to eq(detailed_rating)
    end

    it 'a review should contain the overliest positive score with nil value' do
      expect(convert_to_reviews[0].score).to eq(nil)
    end
  end
end
