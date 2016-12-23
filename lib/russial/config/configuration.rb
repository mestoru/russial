# frozen_string_literal: true
class Russial
  class Config
    module Configuration
      attr_writer :config

      def config
        @config ||= Config.new
      end

      def reset
        @config = Config.new
      end

      def configure
        yield(config)
      end
    end
  end
end
