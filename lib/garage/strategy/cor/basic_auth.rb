module Garage
  module Strategy
    module Cor
      class BasicAuth < Base
        def access_token
          if defined?(@access_token)
            @access_token
          elsif target?
            token = Garage::Strategy::AccessToken.new(attributes.merge(token: requested_token, token_type: :basic_auth))
            @access_token = token.accessible? ? token : nil
          end
        end

        private

        def target?
          value = request.authorization
          value.present? && value.starts_with?('Basic ')
        end

        def attribute_names
          %i(application_id expired_at resource_owner_id scope)
        end

        def attributes
          Hash[attribute_names.map {|name| [name, from_header(name)] }]
        end

        def requested_token
          value = request.authorization
          value.gsub(/^Basic\s(.*)/) { $1 }
        end

        def self.configure
          yield(config)
        end

        def self.config
          @config ||= Configuration.new
        end

        class Configuration
          def initialize
            @users = {}
          end

          def register(user, password)
            @users[user] = password
          end
        end
      end
    end
  end
end
