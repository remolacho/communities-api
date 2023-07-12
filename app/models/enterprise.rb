# == Schema Information
#
# Table name: public.enterprises
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :bigint
#
# Indexes
#
#  index_enterprises_on_tenant_id  (tenant_id)
#  index_enterprises_on_token      (token) UNIQUE
#
class Enterprise < ApplicationRecord
  belongs_to :tenant
end
