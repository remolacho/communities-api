# frozen_string_literal: true

module Statuses
  class Property < EnumerateIt::Base
    associate_values(
      property_own: 'pro-own',
      property_rented: 'pro-rented',
      property_loan: 'pro-loan',
      property_empty: 'pro-empty'
    )
  end
end
