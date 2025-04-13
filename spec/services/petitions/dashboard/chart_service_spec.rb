# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Petitions::Dashboard::ChartStatusesService do
  include_context 'dashboard_percentage_stuff'

  context 'when you want get a dashboard by percentage' do
    it do
      statuses = Status.all_of_petitions('es')
      total = petitions + complaints + claims

      pending   = ((3 * 100).to_f / total).round(2)
      reviewing = ((1 * 100).to_f / total).round(2)
      rejected  = ((1 * 100).to_f / total).round(2)
      resolved  = ((1 * 100).to_f / total).round(2)
      confirm   = 0
      rejected_solution = 0

      service = described_class.new(user: user, statuses: statuses)
      result = service.call

      pending_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_PENDING }
      reviewing_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_REVIEWING }
      rejected_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_REJECTED }
      resolved_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_RESOLVED }
      confirm_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_CONFIRM }
      rejected_solution_h = result.detect { |r| r[:code] == ::Statuses::Petition::PETITION_REJECTED_SOLUTION }

      expect(pending_h[:percentage] == pending).to be(true)
      expect(reviewing_h[:percentage] == reviewing).to be(true)
      expect(rejected_h[:percentage] == rejected).to be(true)
      expect(resolved_h[:percentage] == resolved).to be(true)
      expect(confirm_h[:percentage] == confirm).to be(true)
      expect(rejected_solution_h[:percentage] == rejected_solution).to be(true)
    end
  end
end
