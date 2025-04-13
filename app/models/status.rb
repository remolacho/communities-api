# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  color       :string           default("#E8E6E6")
#  name        :jsonb            not null
#  status_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_statuses_on_code  (code) UNIQUE
#
# frozen_string_literal: true

class Status < ApplicationRecord
  include ::Statuses::PetitionFindable
  include ::Statuses::AnswerFindable
  include ::Statuses::PropertyFindable
  has_enumeration_for :status_type, with: Statuses::Types, create_helpers: true
  has_enumeration_for :code, with: Statuses::Codes, create_helpers: true

  has_many :properties, dependent: :restrict_with_error
  has_many :petitions, dependent: :destroy
  has_many :follow_petitions, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :status_type, presence: true

  scope :by_type, -> (type) { where(status_type: type) }
end
