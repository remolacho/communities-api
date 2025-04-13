# frozen_string_literal: true

module Users
  module Searches
    class QueryTermService
      attr_accessor :term, :attr

      def initialize(attr:, term:)
        @term = term
        @attr = attr.presence
      end

      def call
        return if !term.present? || !attr.present?
        return if attr.size > 15 || term.size > 25

        { "#{attr}_cont": term }
      end
    end
  end
end
