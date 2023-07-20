class Users::ProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :lastname,
             :email,
             :address,
             :identifier,
             :phone
end
