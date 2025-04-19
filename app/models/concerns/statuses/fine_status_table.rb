# frozen_string_literal: true

module Statuses
  module FineStatusTable
    extend ActiveSupport::Concern

    included do
      Statuses::FineLegal.enumeration.each do |key, value|
        method_name = key.to_s.sub('fine_', '').concat('?')

        define_method(method_name) do
          status.code.eql?(value.first)
        end
      end

      Statuses::FineWarning.enumeration.each do |key, value|
        method_name = key.to_s.sub('fine_', '').concat('?')

        define_method(method_name) do
          status.code.eql?(value.first)
        end
      end
    end
  end
end
