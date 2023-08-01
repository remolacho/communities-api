# frozen_string_literal: true

class Petitions::Filter::QueryService
  attr_accessor :params

  def initialize(params:)
    @params = params
  end

  def call
    hash = {}.tap do |f|
      f[:status_id_eq] = params[:status_id] if params[:status_id].present?
      f[:category_petition_id_eq] = params[:category_petition_id] if params[:category_petition_id].present?
    end

    return if hash.empty?

    hash
  end
end
