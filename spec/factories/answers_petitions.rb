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
FactoryBot.define do
  factory :answers_petition do
  end
end
