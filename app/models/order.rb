class Order < ApplicationRecord
  include ApiIntegration::FirstApi
  has_many :items

  belongs_to :pickup, class_name: 'Address'
  alias_attribute :pickup_address, :pickup

  belongs_to :drop, class_name: 'Address'
  alias_attribute :drop_address, :drop

  accepts_nested_attributes_for :items, :pickup, :drop
end
