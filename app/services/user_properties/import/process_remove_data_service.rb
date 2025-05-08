# frozen_string_literal: true

module UserProperties
  module Import
    class ProcessRemoveDataService
      attr_reader :user, :data_set

      def initialize(user:)
        @user = user
      end

      def call(data_set)
        @data_set = data_set
        return if data_set.empty?

        prepare_remove
      end

      private

      def prepare_remove
        UserProperty.where(user_id: users, property_id: properties)
          .update_all(active: false)
      end

      def users
        @users ||= User.where(identifier: identifiers).select(:id)
      end

      def properties
        @properties ||= Property.where(location: locations).select(:id)
      end

      def identifiers
        @identifiers ||= data_set.pluck('identificador')
      end

      def locations
        @locations ||= data_set.pluck('localizacion')
      end
    end
  end
end
