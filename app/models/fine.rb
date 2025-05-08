# frozen_string_literal: true

# == Schema Information
#
# Table name: fines
#
#  id               :bigint           not null, primary key
#  fine_type        :string           not null
#  message          :string           not null
#  ticket           :string           not null
#  title            :string           not null
#  token            :string           not null
#  value            :float            default(0.0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_fine_id :bigint           not null
#  property_id      :bigint           not null
#  status_id        :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_fines_on_category_fine_id  (category_fine_id)
#  index_fines_on_property_id       (property_id)
#  index_fines_on_status_id         (status_id)
#  index_fines_on_ticket            (ticket) UNIQUE
#  index_fines_on_token             (token) UNIQUE
#  index_fines_on_user_id           (user_id)
#
class Fine < ApplicationRecord
  include ::Fines::Ransackable
  include ::Fines::Validable
  include ::Fines::FileRoutable
  include ::Statuses::FineStatusTable
  belongs_to :user
  belongs_to :property
  belongs_to :category_fine
  belongs_to :status

  has_enumeration_for :fine_type, with: Fines::Type, create_helpers: true

  has_many_attached :files, dependent: :purge

  ENTITY_TYPE = 'fines'

  MAX_FILES = 2
end
