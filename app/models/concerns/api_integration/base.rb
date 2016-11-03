module ApiIntegration
  module Base
    extend ActiveSupport::Concern

    private
      def send_request(api_url, path, body)
        connection = Faraday.new(api_url)
        @response = connection.post(path) do |faraday|
          faraday.headers['Content-Type'] = "application/json"
          faraday.body = body
        end
        handle_response(@response)
      end

      def handle_response(response)
        unless response.success?
          self.errors.add(:base, @response.errors.map(&:message).join(', '))
          raise ActiveRecord::RecordInvalid.new(self)
        else
          store_response(response_body)
        end
      end

      def response_body
        @response_body ||= JSON.parse(response.body) rescue { 'status' => 'server_error', 'context' => response.body }
      end

      def store_response(response)

      end
  end
end
