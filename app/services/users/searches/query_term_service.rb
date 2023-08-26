# frozen_string_literal: true

class Users::Searches::QueryTermService
  attr_accessor :term, :attr

  def initialize(attr:, term:)
    @term = term
    @attr = attr.presence
  end

  def call
    return if !term.present? || !attr.present?
    return if attr.size > 15 || term.size > 25

    { "#{attr}_cont".to_sym => term }
  end
end
