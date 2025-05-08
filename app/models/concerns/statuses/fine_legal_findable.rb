# frozen_string_literal: true

module Statuses
  module FineLegalFindable
    extend ActiveSupport::Concern

    included do
      scope :all_of_fine_legals, lambda { |lang|
        where(status_type: ::Statuses::Types::FINE_LEGAL)
          .select("id, code, color, name::json->>'#{lang}' as as_name")
      }

      ::Statuses::FineLegal.enumeration.each do |key, value|
        define_singleton_method key.to_s do
          find_by(status_type: ::Statuses::Types::FINE_LEGAL, code: value.first)
        end
      end
    end
  end
end
