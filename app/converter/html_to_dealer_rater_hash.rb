# frozen_string_literal: true

require 'nokogiri'

module Converter
  class HtmlToDealerRaterHash
    def add(html_page)
      @html_page = html_page
      review_nodes = get_reviews

      review_nodes.each { |review_node| reviews << convert_to_hash(review_node) }
      reviews
    end

    def reviews
      @reviews ||= []
    end

    private

    def get_reviews
      html = Nokogiri::HTML(@html_page)
      html.xpath("//div[@class='review-entry col-xs-12 text-left pad-none pad-top-lg  border-bottom-teal-lt']")
    end

    def convert_to_hash(review_node)
      @review_node = review_node

      {
        date: review_date,
        title: review_title,
        text: review_text,
        number_of_employees_worked_with: review_number_of_employees_worked_with,
        has_photo: review_has_photo?,
        rating: review_rating,
        detailed_rating: review_detailed_rating
      }
    end

    def review_date
      @review_node.children[3].children[1].content
    end

    def review_title
      @review_node.children[5].children[3].children[1].content.gsub("\n",'').gsub("\r",'').gsub('"','').strip
    end

    def review_text
      @review_node.children[5].children[7].children[1].content.gsub("\n",'').gsub("\r",'').gsub('Read More', '').strip
    end

    def review_number_of_employees_worked_with
      @review_node.children[5].children[15].to_s.scan("data-emp-id").size
    end

    def review_has_photo?
      @review_node.children[5].to_s.scan('lotshotPhoto').size > 0
    end

    def review_rating
      @review_node.children[3].children[3].children[3].to_s.scan(/rating-\d+/).first.match(/\d+/)[0].to_i
    end

    def review_detailed_rating
      node_with_detailed_rating = @review_node.children[5].children[11].children[3]

      {
        customer_service: node_with_detailed_rating.children[1].to_s.scan(/rating-\d+/)[0].match(/\d+/)[0].to_i,
        quality_of_work: node_with_detailed_rating.children[5].to_s.scan(/rating-\d+/)[0].match(/\d+/)[0].to_i,
        friendliness: node_with_detailed_rating.children[9].to_s.scan(/rating-\d+/)[0].match(/\d+/)[0].to_i,
        pricing: node_with_detailed_rating.children[13].to_s.scan(/rating-\d+/)[0].match(/\d+/)[0].to_i,
        overall_experience: node_with_detailed_rating.children[17].to_s.scan(/rating-\d+/)[0].match(/\d+/)[0].to_i
      }
    end
  end
end  