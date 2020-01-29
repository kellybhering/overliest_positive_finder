# frozen_string_literal: true

module DTO
  module Review
    class Base
      attr_accessor :score
    end

    def to_s
      raise NotImplementedError
    end
  end
end
