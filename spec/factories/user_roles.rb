# frozen_string_literal: true

# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  created_by :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_roles_on_role_id              (role_id)
#  index_user_roles_on_user_id              (user_id)
#  index_user_roles_on_user_id_and_role_id  (user_id,role_id) UNIQUE
#
FactoryBot.define do
  factory :user_role do
    user_id { user_id }
    role_id { role_id }
    created_by { user_id }
  end
end
