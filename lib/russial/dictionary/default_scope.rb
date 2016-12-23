# frozen_string_literal: true
class Russial
  module Dictionary
    module DefaultScope
      def default_scope
        @default_scope ||= keys.reverse.to_h.values[0...-1]
      end

      def result
        dictionary.dig(*default_scope, path.last)
      end
    end
  end
end
