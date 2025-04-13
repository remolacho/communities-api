# frozen_string_literal: true

module BaseZero
  class CreateStatusesService
    def initialize
      @statuses = Shared::StatusList.all
    end

    def call
      create_statuses
    end

    private

    attr_reader :statuses

    def create_statuses
      statuses.each do |status_attrs|
        Status.find_or_create_by!(status_attrs)
      end
    end
  end
end
