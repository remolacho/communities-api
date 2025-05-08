# == Schema Information
#
# Table name: answers_petitions
#
#  id          :bigint           not null, primary key
#  message     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  petition_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_answers_petitions_on_petition_id  (petition_id)
#  index_answers_petitions_on_user_id      (user_id)
#
class AnswersPetition < ApplicationRecord
  include ::AnswersPetitions::FileRoutable

  belongs_to :petition
  belongs_to :user
  has_one :group_role, through: :petition

  has_many_attached :files, dependent: :purge

  MAX_FILES = 2

  validates :message,
            length: {
              minimum: 10,
              maximum: 500
            }
end
