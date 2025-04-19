# frozen_string_literal: true

module Properties
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(_auth_object = nil)
        ['active', 'created_at', 'enterprise_id', 'id', 'location', 'property_type_id', 'status_id', 'updated_at']
      end

      def self.ransackable_associations(_auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
