class Order < ApplicationRecord
  has_many :items, dependent: :destroy

  belongs_to :pickup, class_name: 'Address', dependent: :destroy
  alias_attribute :pickup_address, :pickup

  belongs_to :drop, class_name: 'Address', dependent: :destroy
  alias_attribute :drop_address, :drop

  accepts_nested_attributes_for :items, :pickup, :drop

  after_create :push_order

  private
    def push_order
      API_CLASSES.each do |klass|
        service = klass.new(self)
        break if service.push_order
        self.errors.add(:base, 'order request cannot be completed')
        raise ActiveRecord::RecordInvalid if klass.eql?(API_CLASSES.last)
      end
    end
end
