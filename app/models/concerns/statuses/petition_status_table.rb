# frozen_string_literal: true

module Statuses
  module PetitionStatusTable
    extend ActiveSupport::Concern

    included do
      Statuses::Petition.enumeration.each do |key, value|
        method_name = key.to_s.sub('petition_', '').concat('?')

        define_method(method_name) do
          status.code.eql?(value.first)
        end
      end
    end
  end
end
