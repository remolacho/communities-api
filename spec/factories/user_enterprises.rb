# frozen_string_literal: true

# == Schema Information
#
# Table name: user_enterprises
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_user_enterprises_on_enterprise_id              (enterprise_id)
#  index_user_enterprises_on_user_id                    (user_id)
#  index_user_enterprises_on_user_id_and_enterprise_id  (user_id,enterprise_id) UNIQUE

FactoryBot.define do
  factory :user_enterprise do
    user_id { user_id }
    enterprise_id { enterprise_id }
    active { active }
  end
end
