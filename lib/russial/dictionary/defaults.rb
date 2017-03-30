# frozen_string_literal: true
class Russial
  module Dictionary
    module Defaults
      def initialize_defaults
        default_scope
        default_value
      end

      def default_scope
        @default_scope ||= keys.any? && keys.first.scope
      end

      def result
        dictionary.dig(*default_scope, path.last)
      end

      def to_s
        word.to_s
      end
      alias default_value to_s

      private

      def method_missing(name, *args, &block)
        return super unless default_value.respond_to?(name)

        default_value.send(name)
      end

      def respond_to_missing?(name, include_private = false)
        default_value.respond_to?(name) || super
      end
    end
  end
end
