# frozen_string_literal: true

module Fines
  class Policy < BasePolicy
    def can_read!
      loudly { role?(:can_read) }
    end

    def can_write!
      loudly { role?(:can_write) }
    end

    def can_destroy!
      loudly { role?(:can_destroy) }
    end

    def can_change_status!
      loudly { role?(:can_change_status) }
    end

    def can_change_status?
      role?(:can_change_status)
    end

    private

    def entity
      @entity ||= Fine.name
    end
  end
end
