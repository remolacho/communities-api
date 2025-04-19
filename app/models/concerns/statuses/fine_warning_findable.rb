# frozen_string_literal: true

module Statuses
  module FineWarningFindable
    extend ActiveSupport::Concern

    included do
      scope :all_of_fine_warnings, lambda { |lang|
        where(status_type: ::Statuses::Types::FINE_WARNING)
          .select("id, code, color, name::json->>'#{lang}' as as_name")
      }

      ::Statuses::FineWarning.enumeration.each do |key, value|
        define_singleton_method key.to_s do
          find_by(status_type: ::Statuses::Types::FINE_WARNING, code: value.first)
        end
      end
    end
  end
end
