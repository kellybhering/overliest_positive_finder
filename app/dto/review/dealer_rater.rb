# frozen_string_literal: true

module DTO
  module Review
    class DealerRater < Base
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

      def to_s
        "*  #{score} score *\r\n"\
        "#{date} [rating #{rating}]\r\n"\
        "(#{has_photo ? 'with' : 'without'} photo | #{number_of_employees_worked_with} #{number_of_employees_worked_with == 1 ? 'employee' : 'employees'} worked with)\r\n\r\n"\
        "Title: #{title}\r\n\r\n"\
        "Review: #{text}"
      end
    end
  end
end
