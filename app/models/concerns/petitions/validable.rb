module Petitions
  module Validable
    extend ActiveSupport::Concern

    included do
      validates :title,
                length: {
                  minimum: 5,
                  maximum: 50
                }
      validates :message,
                length: {
                  minimum: 10,
                  maximum: 500
                }
    end
  end
end
