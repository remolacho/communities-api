# == Schema Information
#
# Table name: petitions
#
#  id                   :bigint           not null, primary key
#  message              :string           not null
#  ticket               :string           not null
#  title                :string           not null
#  token                :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_petition_id :bigint           not null
#  group_role_id        :bigint           not null
#  status_id            :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_petitions_on_category_petition_id  (category_petition_id)
#  index_petitions_on_group_role_id         (group_role_id)
#  index_petitions_on_status_id             (status_id)
#  index_petitions_on_ticket                (ticket) UNIQUE
#  index_petitions_on_token                 (token) UNIQUE
#  index_petitions_on_user_id               (user_id)
#
class Petition < ApplicationRecord
  include ::Petitions::Statustable
  include ::Petitions::Ransackable
  include ::Petitions::Validable
  include ::Petitions::FileRoutable

  belongs_to :user
  belongs_to :status
  belongs_to :group_role
  belongs_to :category_petition
  has_many :answers_petitions
  has_many :roles, through: :group_role
  has_many :follow_petitions

  has_many_attached :files, dependent: :purge

  MAX_PETITION_FILES = 2
end
