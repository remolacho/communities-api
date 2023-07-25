class Users::BasicProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :lastname
end
