# frozen_string_literal: true

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
class CategoryFine < ApplicationRecord
  ENTITY_TYPE = 'category_fines'

  # Associations
  belongs_to :created_by, class_name: 'User'
  belongs_to :enterprise
  belongs_to :parent_category_fine, class_name: 'CategoryFine', optional: true

  has_many :child_category_fines, class_name: 'CategoryFine',
                                  foreign_key: 'parent_category_fine_id',
                                  dependent: :destroy

  has_many :fines, dependent: :restrict_with_error

  # Validations
  validates :code, presence: true, uniqueness: { scope: :enterprise_id }
  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :roots, -> { where(parent_category_fine_id: nil) }

  scope :with_recursive_children, lambda { |root_ids|
    find_by_sql([<<-SQL, { root_ids: root_ids }])
      WITH RECURSIVE category_tree AS (
        SELECT
          cf.*,
          0 as depth,
          ARRAY[cf.id] as path
        FROM category_fines cf
        WHERE cf.id IN (:root_ids)
          AND cf.active = true

        UNION ALL

        SELECT
          child.*,
          ct.depth + 1,
          ct.path || child.id
        FROM category_fines child
        INNER JOIN category_tree ct ON ct.id = child.parent_category_fine_id
        WHERE child.active = true
      )
      SELECT *
      FROM category_tree
      ORDER BY path, depth
    SQL
  }
end
