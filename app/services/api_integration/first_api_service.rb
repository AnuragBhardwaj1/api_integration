module ApiIntegration
  class FirstApiService < BaseService
    attr_accessor :response

    def push_order
      connection = Faraday.new(FIRST_API_URL)
      @response = connection.post('/order'.freeze) do |faraday|
        faraday.headers['Content-Type'] = "application/json"
        faraday.body = OrderSerializer.new(@order).to_json
      end
      store_response if response.success?
      response.success?
    end

    private

      def store_response
        @order.update_columns(response_hash)
      end

      def response_hash
        response_body['response'].merge({request_id: response_body['request_id']})
      end
  end
end
