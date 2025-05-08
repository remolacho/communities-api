# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_permissions
#
#  id                 :bigint           not null, primary key
#  can_change_status  :boolean          default(FALSE)
#  can_destroy        :boolean          default(FALSE)
#  can_read           :boolean          default(FALSE)
#  can_write          :boolean          default(FALSE)
#  custom_permissions :jsonb
#  entity_type        :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  role_id            :bigint           not null
#
# Indexes
#
#  index_entity_permissions_on_role_id                  (role_id)
#  index_entity_permissions_on_role_id_and_entity_type  (role_id,entity_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :entity_permission do
    association :role

    # Por defecto, sin permisos
    can_read { false }
    can_write { false }
    can_destroy { false }
    can_change_status { false }
    custom_permissions { {} }

    # Trait para permisos completos
    trait :full_access do
      can_read { true }
      can_write { true }
      can_destroy { true }
      can_change_status { true }
    end

    # Trait para permisos de solo lectura
    trait :read_only do
      can_read { true }
    end

    factory :enterprise_full_access do
      entity_type { 'Enterprise' }
      full_access
    end

    factory :enterprise_read_only do
      entity_type { 'Enterprise' }
      read_only
    end
  end
end
