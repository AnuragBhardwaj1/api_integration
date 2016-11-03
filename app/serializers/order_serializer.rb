class OrderSerializer < ActiveModel::Serializer
  attributes :customer_name, :items, :pickup_address, :drop

  def customer_name
    object.name
  end

  def items
    object.items.map { |item| ItemSerializer.new(item).as_json.deep_transform_keys { |key| key.to_s.camelize } }
  end

  def pickup_address
    AddressSerializer.new(object.pickup_address).as_json
  end

  def drop
    AddressSerializer.new(object.drop_address).as_json
  end
end
