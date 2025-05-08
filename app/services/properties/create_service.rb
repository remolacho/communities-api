# frozen_string_literal: true

module Properties
  class CreateService
    attr_reader :user, :params

    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      validate_property_type!

      create_property
    end

    private

    def validate_property_type!
      return if property_type.present?

      raise ActiveRecord::RecordNotFound,
            I18n.t('services.properties.create.errors.property_type_not_found')
    end

    def create_property
      user.enterprise.properties.create!(
        property_type: property_type,
        location: params[:location],
        status_id: params[:status_id]
      )
    end

    def property_type
      @property_type ||= PropertyType.active.find_by(id: params[:property_type_id])
    end
  end
end
