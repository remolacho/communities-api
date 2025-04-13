# frozen_string_literal: true

module UserEnterprises
  class Create
    attr_accessor :enterprise

    def initialize(enterprise:)
      @enterprise = enterprise
    end

    def call(user)
      enterprise.user_enterprises.create!(user_id: user.id)
    end
  end
end
