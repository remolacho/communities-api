module Petitions
  module Statustable
    extend ActiveSupport::Concern

    def pending?
      status.code.eql?(Status::PETITION_PENDING)
    end

    def reviewing?
      status.code.eql?(Status::PETITION_REVIEWING)
    end

    def rejected?
      status.code.eql?(Status::PETITION_REJECTED)
    end

    def by_confirm?
      status.code.eql?(Status::PETITION_CONFIRM)
    end

    def rejected_solution?
      status.code.eql?(Status::PETITION_REJECTED_SOLUTION)
    end

    def resolved?
      status.code.eql?(Status::PETITION_RESOLVE)
    end
  end
end
