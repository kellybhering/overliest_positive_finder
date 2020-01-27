# frozen_string_literal: true

module DTO
  class DealerRaterReview < BaseReview
    attr_reader :date, :title, :text, :number_of_employees_worked_with,
                :has_photo, :rating, :detailed_rating
   
    def initialize(date:, title:, text:, number_of_employees_worked_with:, has_photo:, rating:,
      detailed_rating:)
      @date = date 
      @title = title 
      @text = text 
      @number_of_employees_worked_with = number_of_employees_worked_with 
      @has_photo = has_photo 
      @rating = rating 
      @detailed_rating = detailed_rating
    end
  end
end