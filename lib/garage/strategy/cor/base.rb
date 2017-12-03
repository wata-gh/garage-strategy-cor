module Garage
  module Strategy
    module Cor
      class Base
        attr_reader :controller, :successor

        def initialize(controller, successor)
          @controller = controller
          @successor = successor
        end

        private

        def request
          @controller.request
        end

        def params
          @controller.params
        end

        def from_header(name)
          canonical = name.to_s.dasherize.split('-').map(&:capitalize).join('-')
          request.headers[canonical]
        end
      end
    end
  end
end
