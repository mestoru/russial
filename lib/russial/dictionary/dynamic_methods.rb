# frozen_string_literal: true
class Russial
  module Dictionary
    module DynamicMethods
      def initialize(*)
        super
        generate_methods
        generate_aliases
      end

      private

      def generate_methods
        keys.each do |_, key|
          define_singleton_method(key) do
            path << key unless path.include? key
            get
          end
        end
      end

      def generate_aliases
        singleton_class.class_eval do
          superclass.config.aliases.each { |a, m| alias_method a, m }
        end
      end

      def get
        case (memoized_result = result)
        when Hash
          self
        when String
          soft_reset_path
          memoized_result
        end
      end

      def keys
        @keys ||= extract_keys(dictionary).flatten(1)
      end

      def extract_keys(hash, depth = 0)
        hash.map do |k, v|
          if v.is_a? Hash
            extract_keys(v, depth.succ) << [depth, k]
          else
            [depth, k]
          end
        end
      end
    end
  end
end
