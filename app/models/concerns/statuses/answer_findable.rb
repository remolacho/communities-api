# frozen_string_literal: true

module Statuses
  module AnswerFindable
    extend ActiveSupport::Concern

    included do
      ::Statuses::Answer.enumeration.each do |key, value|
        define_singleton_method key.to_s do
          find_by(status_type: ::Statuses::Types::ANSWER, code: value.first)
        end
      end
    end
  end
end
