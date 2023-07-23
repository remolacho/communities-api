# == Schema Information
#
# Table name: follow_petitions
#
#  id          :bigint           not null, primary key
#  observation :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  petition_id :bigint
#  status_id   :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_follow_petitions_on_petition_id  (petition_id)
#  index_follow_petitions_on_status_id    (status_id)
#  index_follow_petitions_on_user_id      (user_id)
#
class FollowPetition < ApplicationRecord
  belongs_to :petition
  belongs_to :user
  belongs_to :status
end
