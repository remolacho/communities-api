module Petitions
  module Statustable
    extend ActiveSupport::Concern

    def pending?
      self.status.code.eql?(Status::PETITION_PENDING)
    end

    def reviewing?
      self.status.code.eql?(Status::PETITION_REVIEWING)
    end

    def rejected?
      self.status.code.eql?(Status::PETITION_REJECTED)
    end

    def by_confirm?
      self.status.code.eql?(Status::PETITION_CONFIRM)
    end

    def rejected_solution?
      self.status.code.eql?(Status::PETITION_REJECTED_SOLUTION)
    end

    def resolved?
      self.status.code.eql?(Status::PETITION_RESOLVE)
    end
  end
end
