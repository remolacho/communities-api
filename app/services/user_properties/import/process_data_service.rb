# frozen_string_literal: true

module UserProperties
  module Import
    class ProcessDataService
      attr_reader :user, :data_set

      def initialize(user:)
        @user = user
      end

      def call(data_set)
        @data_set = data_set
        return if data_set.empty?

        prepare_upsert
      end

      private

      def prepare_upsert
        records = data_set.map do |row|
          user = users[row['identificador']]
          property = properties[row['localizacion']]

          unless user
            raise ActiveRecord::RecordNotFound,
                  I18n.t('services.user_properties.import.process_data.errors.user_not_found',
                         identifier: row['identificador'])
          end

          unless property
            raise ActiveRecord::RecordNotFound,
                  I18n.t('services.user_properties.import.process_data.errors.property_not_found',
                         location: row['localizacion'])
          end

          {
            user_id: user.id,
            property_id: property.id,
            property_owner_type_id: PropertyOwnerType.default.id,
            active: true
          }
        end

        UserProperty.upsert_all(records, unique_by: [:user_id, :property_id])
      end

      def users
        @users ||= User.where(identifier: identifiers).index_by(&:identifier)
      end

      def properties
        @properties ||= Property.where(location: locations).index_by(&:location)
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
