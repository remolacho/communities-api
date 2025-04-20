# frozen_string_literal: true

module Statuses
  module PetitionFindable
    extend ActiveSupport::Concern

    included do
      scope :all_of_petitions, lambda { |lang|
        where(status_type: ::Statuses::Types::PETITION)
          .select("id, code, color, name::json->>'#{lang}' as as_name")
      }

      ::Statuses::Petition.enumeration.each do |key, value|
        define_singleton_method key.to_s do
          find_by(status_type: ::Statuses::Types::PETITION, code: value.first)
        end
      end
    end
  end
end
