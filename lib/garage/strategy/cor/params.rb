module Garage
  module Strategy
    module Cor
      class Params < Base
        def access_token
          if defined?(@access_token)
            @access_token
          elsif target? && valid?
            token = Garage::Strategy::AccessToken.new(attributes.merge(token: params[:identifier], token_type: "params_#{self.class.config.parameter_name}".to_sym))
            @access_token = token.accessible? ? token : nil
          end
        end

        private

        def target?
          params.key?(parameter_name)
        end

        def parameter_name
          self.class.config.parameter_name
        end

        def valid?
          validator = self.class.config.validator
          return true unless validator

          validator.valid_params?(self)
        end

        def attribute_names
          %i(application_id expired_at resource_owner_id scope)
        end

        def attributes
          Hash[attribute_names.map {|name| [name, from_header(name)] }]
        end

        def self.configure
          yield(config)
        end

        def self.config
          @config ||= Configuration.new
        end

        class Configuration
          def parameter_name=(parameter_name)
            @parameter_name = parameter_name
          end

          def parameter_name
            unless defined?(@parameter_name)
              raise "Garage::Strategy::Cor::Params::Configuraion.paramter_name must be configured."
            end
            @parameter_name
          end

          def validator=(validator)
            @validator = validator
          end

          def validator
            @validator
          end
        end
      end
    end
  end
end
