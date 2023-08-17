# == Schema Information
#
# Table name: suggestions
#
#  id         :bigint           not null, primary key
#  anonymous  :boolean          default(FALSE)
#  message    :string           not null
#  readed     :boolean          default(FALSE)
#  ticket     :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_suggestions_on_ticket   (ticket) UNIQUE
#  index_suggestions_on_token    (token) UNIQUE
#  index_suggestions_on_user_id  (user_id)
#
class Suggestion < ApplicationRecord
  include ::Suggestions::Validable
  include ::Suggestions::FileRoutable
  include ::Suggestions::Ransackable

  belongs_to :user
  has_many_attached :files, dependent: :purge

  ENTITY_TYPE = 'suggestions'

  MAX_FILES = 2
end
