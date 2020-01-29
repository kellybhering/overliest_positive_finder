# frozen_string_literal: true

require 'spec_helper'

describe Converter::HtmlToDealerRaterHash do
  describe '#add' do
    subject(:add_reviews) { described_class.new.add(html_page) }

    context 'with reviews returned' do
      let(:html_page) { File.read('./spec/fixtures/dealer_rater_page_1.html') }

      it 'shoud add 10 reviews' do
        expect(add_reviews.size).to eq(10)
      end  

      it 'a review hash should contain a date' do
        expect(add_reviews[0][:date]).to eq('January 24, 2020')
      end

      it 'a review hash should contain a title' do
        expect(add_reviews[0][:title]).to eq('Thank you McKaig and David Varner for all your hard work...')
      end

      it 'a review hash should contain a text' do
        expect(add_reviews[0][:text]).to eq('Thank you McKaig and David Varner for all your hard work to assure us of a safe and reliable vehicle. We are very pleased with our SUV. The Lord has blessed us.')
      end

      it 'a review hash should contain the number of employees worked with' do
        expect(add_reviews[0][:number_of_employees_worked_with]).to eq(1)
      end

      it 'a review hash should inform if a user photo was included' do
        expect(add_reviews[0][:has_photo]).to eq(false)
      end

      it 'a review hash should contain the rating' do
        expect(add_reviews[0][:rating]).to eq(50)
      end

      it 'a review hash should contain the detailed rating' do
        detailed_rating = {
          customer_service: 0,
          quality_of_work: 0,
          friendliness: 0,
          pricing: 0,
          overall_experience: 50
        }

        expect(add_reviews[0][:detailed_rating]).to eq(detailed_rating)
      end
    end
  end
end