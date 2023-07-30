# frozen_string_literal: true

module Petitions
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(auth_object = nil)
        %w[category_petition_id created_at group_role_id id message status_id ticket title token updated_at user_id]
      end

      def self.ransackable_associations(auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
