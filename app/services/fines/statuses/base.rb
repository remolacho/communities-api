# frozen_string_literal: true

module Fines
  module Statuses
    class Base
      attr_accessor :user, :fine

      def initialize(user:, fine:)
        @user = user
        @fine = fine
      end

      def call
        return [] unless can_view?

        serializer
      end

      private

      def serializer
        ActiveModelSerializers::SerializableResource.new(statuses,
                                                         each_serializer: ::Statuses::DetailSerializer).as_json
      end

      def statuses
        raise NotImplementedError
      end

      def can_view?
        raise NotImplementedError
      end

      def owner?
        property_users_ids.include?(user.id)
      end

      def creator?
        fine.user_id == user.id
      end

      def property_users_ids
        @property_users_ids ||= fine.property.users.ids
      end

      def policy
        @policy ||= ::Fines::Policy.new(current_user: user)
      end
    end
  end
end
