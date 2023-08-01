# == Schema Information
#
# Table name: category_petitions
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  slug               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  enterprise_id      :bigint           not null
#  parent_category_id :integer
#
# Indexes
#
#  index_category_petitions_on_enterprise_id       (enterprise_id)
#  index_category_petitions_on_parent_category_id  (parent_category_id)
#  index_category_petitions_on_slug                (slug) UNIQUE
#
FactoryBot.define do
  factory :category_petition do
    enterprise { enterprise }
  end

  trait :petition do
    name { 'Petición' }
    slug { 'Petición'.parameterize }
  end

  trait :complaint do
    name { 'Queja' }
    slug { "Queja".parameterize }
  end

  trait :claim do
    name { 'Reclamo' }
    slug { 'Reclamo'.parameterize }
  end
end
