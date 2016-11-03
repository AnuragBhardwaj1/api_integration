module ApiIntegration
    module FirstApi
      extend ActiveSupport::Concern
      include ApiIntegration::Base

      included do
        after_create :generate_order_request
      end

      def generate_order_request
        send_request('http://localhost:4000', '/order', request_hash(self))
      end

      private

        # def send_request(body)
        #   connection = Faraday.new('http://localhost:4000')
        #   @response = connection.post('/order') do |faraday|
        #     faraday.headers['Content-Type'] = "application/json"
        #     faraday.body = body
        #   end
        #   JSON.parse(@response.body)
        # end
    end
  end


def request_hash(order)
  {
    "customer_name": order.name,
    "items": [
      {
        "name": "cylinder",
        "type": "volatile"
      },
      {
        "name": "ac",
        "type": "non-volatile"
      }
    ],
    "pickup_address": {
      "house": "123",
      "area": "A-block, Rajender place",
      "city": "Delhi",
      "State": "Delhi",
      "pincode": "110011"
    },
    "drop": {
      "hosue": "5/2",
      "area": "W-block, DLF Phase 3",
      "city": "Gurgaon",
      "State": "Haryana",
      "pincode": "122002"
    }
  }.to_json
end
