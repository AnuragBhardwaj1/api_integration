class RequestPickupSerializer < ActiveModel::Serializer
  attributes :items, :pickup_address, :drop_address

  def items
    object.items.map { |item| ItemSerializer.new(item).as_json.deep_transform_keys { |key| key.to_s.camelize } }
  end

  def pickup_address
    address = object.pickup_address
    "#{ address.house_number}, #{ address.block }, #{ address.locality },  #{ address.city } - #{ address.pincode }"
  end

  def drop_address
    address = object.drop_address
    "#{ address.house_number}, #{ address.block }, #{ address.locality },  #{ address.city } - #{ address.pincode }"
  end
end
