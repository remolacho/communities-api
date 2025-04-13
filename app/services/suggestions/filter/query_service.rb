# frozen_string_literal: true

module Suggestions
  module Filter
    class QueryService
      attr_accessor :params

      def initialize(params:)
        @params = params
      end

      def call
        {}.tap do |f|
          f[:read_eq] = params[:read]
          f[:anonymous_eq] = params[:anonymous]
        end
      end
    end
  end
end
