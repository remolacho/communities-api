# frozen_string_literal: true

class User
  module Ransackable
    extend ActiveSupport::Concern

    included do
      def self.ransackable_attributes(auth_object = nil)
        %w[name email token address lastname identifier phone]
      end

      def self.ransackable_associations(auth_object = nil)
        reflect_on_all_associations.map(&:name).map(&:to_s)
      end
    end
  end
end
