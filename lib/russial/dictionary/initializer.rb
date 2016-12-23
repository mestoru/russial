# frozen_string_literal: true
class Russial
  module Dictionary
    module Initializer
      private

      def prepare_dictionary(dictionary)
        dictionary[word] || super
      rescue NoMethodError
        {}
      end
    end
  end
end
