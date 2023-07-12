# == Schema Information
#
# Table name: public.tenants
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string           not null
#  scheme     :string           not null
#  subdomain  :string
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tenants_on_name       (name) UNIQUE
#  index_tenants_on_scheme     (scheme) UNIQUE
#  index_tenants_on_subdomain  (subdomain) UNIQUE
#  index_tenants_on_token      (token) UNIQUE
#
class Tenant < ApplicationRecord
  has_one :enterprise
end
