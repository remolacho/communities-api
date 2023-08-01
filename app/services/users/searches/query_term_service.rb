# frozen_string_literal: true

class Users::Searches::QueryTermService
  attr_accessor :term, :attr

  def initialize(attr:, term:)
    @term = term
    @attr = attr.presence || 'name'
  end

  def call
    return unless term.present?
    return if attr.size > 15
    return if term.size > 25

    { "#{attr}_cont".to_sym => term }
  end
end
