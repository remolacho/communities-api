# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  name        :jsonb            not null
#  status_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_statuses_on_code  (code) UNIQUE
#
class Status < ApplicationRecord
  include PetitionStatustable
  include AnswerStatustable

  has_many :petitions
  has_many :follow_petitions
end
