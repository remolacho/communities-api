# frozen_string_literal: true

module Users
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(_auth_object = nil)
        ['name', 'email', 'token', 'reference', 'lastname', 'identifier', 'phone']
      end

      def self.ransackable_associations(_auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
