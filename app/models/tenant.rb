# == Schema Information
#
# Table name: public.tenants
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  subdomain  :string
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tenants_on_subdomain  (subdomain) UNIQUE
#  index_tenants_on_token      (token) UNIQUE
#
class Tenant < ApplicationRecord
  after_create :create_tenant

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
