# frozen_string_literal: true

module Properties
  class ListService
    attr_reader :user, :filter, :enterprise

    def initialize(user:, filter:)
      @user = user
      @filter = filter
      @enterprise = user.enterprise
    end

    def call(page = 1)
      enterprise.properties
        .active
        .select('properties.*, property_types.name as property_type_name, statuses.name as status_name')
        .joins(:property_type, :status)
        .ransack(filter.call)
        .result
        .page(page)
    end
  end
end
