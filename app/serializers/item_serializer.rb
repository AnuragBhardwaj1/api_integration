class ItemSerializer < ActiveModel::Serializer
  attributes :name, :type

  def name
    object.name
  end

  def type
    object.type
  end
end
