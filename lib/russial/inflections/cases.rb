# frozen_string_literal: true
class Russial
  module Inflections
    module Cases
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def cases(args)
          args.each do |arg|
            define_method(arg) do
              get_word_by_inflection(arg)
            end
            alias_method(arg[0], arg)
          end
        end
      end
    end
  end
end
