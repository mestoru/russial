# frozen_string_literal: true
class Russial
  class Config
    attr_accessor :aliases, :i18n_scope

    def initialize
      @aliases = {}
      @i18n_scope = :russial
    end
  end
end
