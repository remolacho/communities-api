# == Schema Information
#
# Table name: suggestions
#
#  id         :bigint           not null, primary key
#  anonymous  :boolean          default(FALSE)
#  message    :string           not null
#  read       :boolean          default(FALSE)
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
FactoryBot.define do
  factory :suggestion do
    
  end
end
