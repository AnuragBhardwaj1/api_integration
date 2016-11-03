module ApiIntegration
  class SecondApiService < BaseService
    attr_accessor :response

    def push_order
      connection = Faraday.new(SECOND_API_URL)
      @response = connection.post('/request_pickup'.freeze) do |faraday|
        faraday.headers['Content-Type'] = "application/json"
        faraday.body = RequestPickupSerializer.new(@order).to_json
      end
      store_response if response.success?
      response.success?
    end

    def status
      connection = Faraday.new(SECOND_API_URL)
      @response = connection.post('/status'.freeze) do |faraday|
        faraday.headers['Content-Type'] = "application/json"
        faraday.body = { id: @order.request_id }.to_json
      end
      response_body
    end

    private
      def store_response
        @order.update_column(:request_id, response_body['id'])
      end
  end
end
