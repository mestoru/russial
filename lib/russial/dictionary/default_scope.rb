# frozen_string_literal: true
class Russial
  module Dictionary
    module DefaultScope
      def default_scope
        @default_scope ||= keys.first.scope
      end

      def result
        dictionary.dig(*default_scope, path.last)
      end
    end
  end
end
