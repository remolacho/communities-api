class Statuses::DetailSerializer < ActiveModel::Serializer
  attributes :id, :code
  attribute :name

  def name
    object.name[I18n.locale.to_s]
  end
end
