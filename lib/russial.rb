# frozen_string_literal: true
require "russial/version"
require "russial/dictionary/default_scope"
require "russial/dictionary/dynamic_methods"

class Russial
  include Dictionary::DefaultScope
  prepend Dictionary::DynamicMethods

  def initialize(word, dictionary)
    @dictionary = dictionary[word.to_sym]
    @path = []
  end

  private

  attr_reader :dictionary
  attr_accessor :path

  def reset_path
    self.path = []
  end

  def result
    dictionary.dig(*path) || super
  end
end
