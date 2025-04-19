# frozen_string_literal: true

module Properties
  class UpdateService
    class InvalidLocationFormat < StandardError; end

    attr_accessor :property, :params, :user, :enterprise

    def initialize(property, params, user)
      @property = property
      @params = params
      @user = user
      @enterprise = user.enterprise
    end

    def call
      validate_property_type! if params[:property_type_id].present?
      validate_status! if params[:status_id].present?

      property.update!(params)
      property.reload
    end

    private

    def validate_property_type!
      PropertyType.find_by!(id: params[:property_type_id], enterprise_id: enterprise.id)
    end

    def validate_status!
      Status.find(params[:status_id])
    end
  end
end
