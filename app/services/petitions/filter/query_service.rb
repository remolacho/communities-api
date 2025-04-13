# frozen_string_literal: true

module Petitions
  module Filter
    class QueryService
      attr_accessor :params

      def initialize(params:)
        @params = params
      end

      def call
        hash = {}.tap do |f|
          f[:status_id_eq] = params[:status_id]
          f[:category_petition_id_eq] = params[:category_petition_id]
        end

        return if hash.empty?

        hash
      end
    end
  end
end
