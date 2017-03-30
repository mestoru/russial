# frozen_string_literal: true
class Russial
  module Dictionary
    module Defaults

      def initialize_defaults
        default_scope
        default_value
      end

      def default_scope
        @default_scope ||= keys.first.scope
      end

      def default_value
        @default_value ||= send(keys.first.name)
      end

      def result
        dictionary.dig(*default_scope, path.last)
      end

      def to_s
        default_value.to_s
      end

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
