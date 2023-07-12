# == Schema Information
#
# Table name: enterprises
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  address    :string
#  name       :string           not null
#  rut        :string           not null
#  subdomain  :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_enterprises_on_rut        (rut) UNIQUE
#  index_enterprises_on_subdomain  (subdomain) UNIQUE
#  index_enterprises_on_token      (token) UNIQUE
#
class Enterprise < ApplicationRecord
end
