# frozen_string_literal: true

module Properties
  module Searches
    class QueryTermService
      attr_accessor :term, :search_attr, :status_id, :property_type_id

      def initialize(params)
        @term = params[:term]
        @search_attr = params[:search_attr].presence
        @status_id = params[:status_id]
        @property_type_id = params[:property_type_id]
      end

      def call
        hash = {}
        hash["#{search_attr}_cont"] = term if search_attr.present? && term.present?
        hash[:status_id_eq] = status_id if status_id.present?
        hash[:property_type_id_eq] = property_type_id if property_type_id.present?
        hash
      end
    end
  end
end
