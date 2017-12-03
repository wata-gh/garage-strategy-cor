module Garage
  module Strategy
    module Cor
      class Configuration
        attr_reader :strategies

        def initialize
          @strategies = []
        end

        def add_strategy(strategy)
          @strategies << strategy
        end
      end
    end
  end
end
