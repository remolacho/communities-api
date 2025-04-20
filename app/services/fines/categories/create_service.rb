# frozen_string_literal: true

module Fines
  module Categories
    class CreateService
      attr_accessor :user, :category_params

      def initialize(user:, **category_params)
        @user = user
        @category_params = category_params
      end

      def call
        create_category
      end

      private

      def create_category
        user.enterprise.category_fines.create!(
          **category_params,
          created_by: user
        )
      end
    end
  end
end
