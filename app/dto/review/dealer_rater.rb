# frozen_string_literal: true

module DTO
  class DealerRaterReview < BaseReview
    attr_reader :date, :title, :text, :number_of_employees_worked_with,
                :has_photo, :review_rating, :detailed_review_rating
   
    def initialize(date:, title:, text:, number_of_employees_worked_with:, has_photo:, review_rating:,
      detailed_review_rating:)
      @date = date 
      @title = title 
      @text = text 
      @number_of_employees_worked_with = number_of_employees_worked_with 
      @has_photo = has_photo 
      @review_rating = review_rating 
      @detailed_review_rating = detailed_review_rating
    end
  end
end