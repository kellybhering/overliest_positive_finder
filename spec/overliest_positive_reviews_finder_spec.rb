# frozen_string_literal: true
#TODO improve file requirement
require './application'

describe OverliestPositiveReviewsFinder do
  describe '.call' do
    subject { described_class.call }

    it 'should return teste' do
      is_expected.to eq('teste')
    end
  end
end