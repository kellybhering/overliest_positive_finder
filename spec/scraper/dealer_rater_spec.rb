# frozen_string_literal: true

require 'spec_helper'

vcr_options = { cassette_name: 'dealer_rater_html_pages', record: :new_episodes }

describe Scraper::DealerRater, vcr: vcr_options do
  describe '#scrap' do
    subject(:scrap_pages) { described_class.new(config).scrap }

    let(:config) { AVAILABLE_REVIEW_SITES[:dealer_rater][:scraper][:config] }

    context 'with content returned' do
      it 'should return 50 reviews' do
        expect(scrap_pages.size).to eq(50)
      end
    end
  end
end
