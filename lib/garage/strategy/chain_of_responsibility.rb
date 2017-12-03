module Garage
  module Strategy
    class ChainOfResponsibility
      class << self
        def configure
          yield(configuration)
        end

        def configuration
          @configuration ||= Cor::Configuration.new
        end
      end
    end
  end
end
