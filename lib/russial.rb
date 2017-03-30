# frozen_string_literal: true

# :nocov:
begin
  require "backport_dig" unless {}.respond_to?(:dig)
rescue LoadError
  puts "Please, install `backport_dig` gem or upgrade your Ruby version."
  exit
end
# :nocov:

require "russial/version"
require "russial/config"
require "russial/config/configuration"
require "russial/dictionary/defaults"
require "russial/dictionary/dynamic_methods"
require "russial/dictionary/initializer"
require "russial/dictionary/i18n"

class Russial
  include Dictionary::Defaults
  include Dictionary::I18n if defined?(I18n)
  prepend Dictionary::DynamicMethods
  prepend Dictionary::Initializer
  extend  Config::Configuration

  def initialize(word, dictionary: {}, substitutions: {})
    @word = word.to_sym
    @dictionary = prepare_dictionary(dictionary)
    @substitutions = substitutions
    @path = []

    initialize_defaults
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
