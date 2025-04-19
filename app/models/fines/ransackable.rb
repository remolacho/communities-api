# frozen_string_literal: true

module Fines
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(_auth_object = nil)
        ['category_fine_id', 'created_at', 'fine_type', 'id', 'message', 'property_id', 'status_id', 'ticket', 'title',
         'token', 'updated_at', 'user_id']
      end

      def self.ransackable_associations(_auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
