# frozen_string_literal: true

class Suggestions::Filter::QueryService
  attr_accessor :params

  def initialize(params:)
    @params = params
  end

  def call
    {}.tap do |f|
      f[:readed_eq] = params[:readed]
      f[:anonymous_eq] = params[:anonymous]
    end
  end
end
