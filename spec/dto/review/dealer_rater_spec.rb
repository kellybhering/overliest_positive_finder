# frozen_string_literal: true

require 'spec_helper'

describe DTO::Review::DealerRater do
  describe '#to_s' do
    subject(:to_string) { dealer_rater_instance.to_s }

    let(:dealer_rater_instance) do
      instance = described_class.new(dealer_rater_hash)
      instance.score = 20
      instance
    end

    let(:dealer_rater_hash) do
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

    it 'should return a formatted text' do
      is_expected.to eq("*  20 score *\r\nJanuary 16, 2020 [rating 49]\r\n(with photo | 2 employees worked with)\r\n\r\nTitle: Title 1\r\n\r\nReview: Text 1")
    end
  end
end
