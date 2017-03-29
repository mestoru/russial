# frozen_string_literal: true
require "backport_dig" unless {}.respond_to?(:dig)

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

  def initialize(word, dictionary: {}, substitutions: {})
    @word = word.to_sym
    @dictionary = prepare_dictionary(dictionary)
    @substitutions = substitutions
    @path = []
  end

  def reset
    reset_path
    self
  end

  private

  attr_reader :dictionary, :word, :substitutions
  attr_accessor :path

  def soft_reset_path
    path.pop
  end

  def reset_path
    self.path = []
  end

  def result
    dictionary.dig(*path) || super
  end
end
