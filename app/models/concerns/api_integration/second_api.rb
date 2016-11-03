module ApiIntegration
    module SecondApi
      extend ActiveSupport::Concern
      include ApiIntegration::Base

      included do
        after_create :request_pickup
      end

      def request_pickup
        send_request('http://localhost:4000', '/request_pickup', request_hash(self))
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
    items: [
      {
        name: "cylinder",
        type: "volatile"
      },
      {
        name: "ac",
        type: "non-volatile"
      }
    ],
    pickup_address: "123, A-Block, Rajender Place, Delhi - 110011",
    drop_address: "5/2, W-block, DLF Phase 3, Gurgaon - 122002"
  }.to_json
end
