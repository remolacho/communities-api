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
#  index_petitions_on_user_id               (user_id)
#
class Petition < ApplicationRecord
  include Statustable

  belongs_to :user
  belongs_to :status
  belongs_to :group_role
  belongs_to :category_petition
  has_many :answers_petitions
  has_many :roles, through: :group_role
  has_many :follow_petitions

  validates :title,
            length: {
              minimum: 5,
              maximum: 50
            }
  validates :message,
            length: {
              minimum: 10,
              maximum: 500
            }
end
