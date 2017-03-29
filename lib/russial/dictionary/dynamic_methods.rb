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
        keys.each do |key|
          name = key.name
          define_singleton_method(name) do
            path << name unless path.include? name
            get
          end
        end
      end

      def generate_aliases
        singleton_class.class_eval do
          superclass.config.aliases.each do |a, m|
            begin
              alias_method a, m
            rescue NameError
              next
            end
          end
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
        @keys ||= extract_keys(dictionary).flatten
      end

      def extract_keys(hash, scope = [])
        hash.map do |k, v|
          if v.is_a? Hash
            extract_keys(v, scope + [k]) << Key.new(k, scope)
          else
            [Key.new(k, scope)]
          end
        end
      end

      Key = Struct.new(:name, :scope)
    end
  end
end
