# frozen_string_literal: true

module CategoriesFines
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

    private

    def entity
      @entity ||= CategoryFine.name
    end
  end
end
