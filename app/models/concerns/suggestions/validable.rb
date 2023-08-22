module Suggestions
  module Validable
    extend ActiveSupport::Concern

    included do
      validates :message,
                length: {
                  minimum: 10,
                  maximum: 500
                }
    end
  end
end
