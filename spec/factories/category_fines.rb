# == Schema Information
#
# Table name: category_fines
#
#  id                      :bigint           not null, primary key
#  active                  :boolean          default(TRUE), not null
#  code                    :string           not null
#  description             :string
#  formula                 :string
#  name                    :string
#  value                   :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  created_by_id           :bigint           not null
#  enterprise_id           :bigint           not null
#  parent_category_fine_id :bigint
#
# Indexes
#
#  index_category_fines_on_code                     (code)
#  index_category_fines_on_created_by_id            (created_by_id)
#  index_category_fines_on_enterprise_id            (enterprise_id)
#  index_category_fines_on_enterprise_id_and_code   (enterprise_id,code) UNIQUE
#  index_category_fines_on_parent_category_fine_id  (parent_category_fine_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#
FactoryBot.define do
  factory :category_fine do
  end
end
