# frozen_string_literal: true

module Suggestions
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(_auth_object = nil)
        ['created_at', 'message', 'ticket', 'title', 'token', 'updated_at', 'user_id', 'read', 'anonymous']
      end

      def self.ransackable_associations(_auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
