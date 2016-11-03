class OrdersController < ApplicationController

  def index
  end

  def create
    @order = Order.new(permitted_resource_params)
    if @order.save
      render json: {
        status: @order.status,
        eta: @order.estimated_pickup_time,
        etd: @order.estimated_delivery_time,
        cost: @order.cost
      }
    else
      render json: {
        error: 'Record Not Saved',
        errors: @order.errors.to_hash,
      },
      status: 422

    end
  end

  private
    def permitted_resource_params
      params.permit(:name, :age, items_attributes: [:name, :type], pickup_attributes: [:house_number, :block, :locality, :city, :state, :pincode], drop_attributes: [:house_number, :block, :locality, :city, :state, :pincode])
    end
end
