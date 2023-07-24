class Petition
  module Statustable
    extend ActiveSupport::Concern

    def resolved?
      self.status.code.eql?(Status::PETITION_RESOLVE)
    end

    def pending?
      self.status.code.eql?(Status::PETITION_PENDING)
    end

    def by_confirm?
      self.status.code.eql?(Status::PETITION_CONFIRM)
    end

    def reviewing?
      self.status.code.eql?(Status::PETITION_REVIEWING)
    end
  end
end