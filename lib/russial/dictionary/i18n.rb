# frozen_string_literal: true
require "i18n"

class Russial
  module Dictionary
    module I18n
      private

      def prepare_dictionary(*)
        ::I18n.t(word, scope: self.class.config.i18n_scope)
      end
    end
  end
end
