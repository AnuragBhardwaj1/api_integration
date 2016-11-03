module ApiIntegration
  class BaseService

    def push_order
      raise 'This method must be Implemented by subclasses'
    end

    private
      def initialize(order)
        @order= order
      end

      def response_body
        @response_body ||= JSON.parse(response.body)
      end
  end
end
