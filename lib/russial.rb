# frozen_string_literal: true
require "russial/version"
require "russial/config"
require "russial/config/configuration"
require "russial/dictionary/default_scope"
require "russial/dictionary/dynamic_methods"
require "russial/dictionary/initializer"
require "russial/dictionary/i18n"

class Russial
  include Dictionary::DefaultScope
  include Dictionary::I18n if defined?(I18n)
  prepend Dictionary::DynamicMethods
  prepend Dictionary::Initializer
  extend  Config::Configuration

  def initialize(word, dictionary: {})
    @word = word.to_sym
    @dictionary = prepare_dictionary(dictionary)
    @path = []
  end

  private

  attr_reader :dictionary, :word
  attr_accessor :path

  def reset_path
    self.path = []
  end

  def result
    dictionary.dig(*path) || super
  end
end
