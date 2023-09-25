# frozen_string_literal: true

class Properties::Imports::CreateService
  attr_accessor :user, :data

  def initialize(user:, data:)
    @user = user
    @data = data
  end

  def perform
    ActiveRecord::Base.transaction do
      data.each do |property_json|
        property = create_property(property_json)
        property_json[:attributes].each { |attr| create_attribute(property, attr) }
      end
    end

    Property.all.count
  rescue StandardError => e
    raise ArgumentError, e
  end

  private

  def create_property(property_json)
    Property.create!(token: SecureRandom.uuid,
                     name: property_json[:name],
                     created_by: user.id,
                     updated_by: user.id)
  end

  def create_attribute(property, attr)
    property.property_attributes.create!(token:      SecureRandom.uuid,
                                         created_by: user.id,
                                         updated_by: user.id,
                                         name:       attr[:name],
                                         min_range:  attr[:min_range],
                                         max_range:  attr[:max_range],
                                         prefix:     attr[:prefix],
                                         name_as:    attr[:name_as])
  end
end
