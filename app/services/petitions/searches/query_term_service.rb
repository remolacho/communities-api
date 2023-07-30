# frozen_string_literal: true

class Petitions::Searches::QueryTermService
  attr_accessor :filter

  def initialize(filter:)
    @filter = filter
  end

  def call
    return unless filter.present?

    if filter[:status_id].present? && filter[:category_petition_id].present?
      return { status_id_eq: filter[:status_id], category_petition_id_eq: filter[:category_petition_id]}
    end

    if filter[:status_id].present?
      return { status_id_eq: filter[:status_id] }
    end

    { category_petition_id_eq: filter[:category_petition_id] }
  end
end
