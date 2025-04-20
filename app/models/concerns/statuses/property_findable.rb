module Statuses
  module PropertyFindable
    extend ActiveSupport::Concern

    included do
      scope :all_of_properties, lambda { |lang|
        where(status_type: ::Statuses::Types::PROPERTY)
          .select("id, code, color, name::json->>'#{lang}' as as_name")
      }

      ::Statuses::Property.enumeration.each do |key, value|
        define_singleton_method key.to_s do
          find_by(status_type: ::Statuses::Types::PROPERTY, code: value.first)
        end
      end
    end
  end
end
