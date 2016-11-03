class OrdersController < ApplicationController

  def index
  end

  def create
    @order = Order.new(permitted_resource_params)
    if @order.save
      render json: create_response
    else
      render json: create_fails_response, status: 422

    end
  end

  private
    def permitted_resource_params
      params.permit(:name, :age, items_attributes: [:name, :type], pickup_attributes: [:house_number, :block, :locality, :city, :state, :pincode], drop_attributes: [:house_number, :block, :locality, :city, :state, :pincode])
    end

    def create_response
      {
        status: @order.status,
        eta: @order.estimated_pickup_time.to_s + ' minutes',
        etd: @order.estimated_delivery_time.to_s + ' minutes',
        cost: @order.cost.to_s + ' Rs.'
      }
    end

    def create_fails_response
      {
        error: 'Record Not Saved',
        errors: @order.errors.to_hash,
      }
    end
end
