class GroupRoles::DetailSerializer < ActiveModel::Serializer
  attributes :id
  attribute :name

  def name
    object.name[I18n.locale.to_s]
  end
end
