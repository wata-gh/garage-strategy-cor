require 'garage/strategy/cor/version'
require 'garage/strategy/chain_of_responsibility'
require 'garage/strategy/cor/base'
require 'garage/strategy/cor/basic_auth'
require 'garage/strategy/cor/configuration'
require 'garage/strategy/cor/params'

module Garage
  module Strategy
    module Cor
      extend ActiveSupport::Concern

      included do
        before_action :verify_auth, if: -> (_) { verify_permission? }
      end

      def verify_permission?
        true
      end

      def access_token
        return @access_token if defined?(@access_token)

        strategy = build_strategy
        loop do
          @access_token = strategy.access_token
          return @access_token if @access_token

          strategy = strategy.successor
          break unless strategy
        end
      end

      def build_strategy
        return @strategies.first if defined?(@strategies)
          
        strategy_classes = Garage::Strategy::ChainOfResponsibility.configuration.strategies
        @strategies = [].tap do |strategies|
          strategy_classes.reverse.inject(nil) do |successor, strategy|
            strategy.new(self, successor).tap { |strategy| strategies.unshift(strategy) }
          end
        end
        @strategies.first
      end
    end
  end
end
