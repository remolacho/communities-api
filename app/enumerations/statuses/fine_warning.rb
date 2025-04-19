# frozen_string_literal: true

module Statuses
  class FineWarning < EnumerateIt::Base
    associate_values(
      fine_warning_assigned: 'fine-warning-assigned',
      fine_warning_closed: 'fine-warning-closed',
      fine_warning_finished: 'fine-warning-finished'
    )
  end
end
