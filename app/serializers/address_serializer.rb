class AddressSerializer < ActiveModel::Serializer
  attributes :house, :area, :city, :state, :pincode

  def house
    object.house_number
  end

  def area
    "#{ object.block }, #{ object.locality }"
  end

  def city
    object.city
  end

  def state
    object.state
  end

  def pincode
    object.pincode
  end
end
