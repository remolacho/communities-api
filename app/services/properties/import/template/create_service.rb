# frozen_string_literal: true

module Properties
  module Import
    module Template
      class CreateService
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def call
          structure = StructureService.new(user: user).call
          xlsx = XlsxService.new(structure: structure).call

          Struct.new(:name_file, :file).new(name_file, xlsx)
        end

        private

        def name_file
          "#{user.enterprise.subdomain}-import-properties.xlsx"
        end
      end
    end
  end
end
