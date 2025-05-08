# == Schema Information
#
# Table name: public.countries
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  code            :string           not null
#  currency_code   :string           not null
#  currency_symbol :string           not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#  index_countries_on_name  (name) UNIQUE
#
class Country < ApplicationRecord
  has_many :enterprises, dependent: :restrict_with_error

  validates :name, :code, :currency_code, :currency_symbol, presence: true
end
