# frozen_string_literal: true
require "russial/version"
require "russial/inflections/cases"

class Russial
  include Inflections::Cases

  cases %i(nominative genitive dative accusative instrumental prepositional)

  def initialize(word, inflections)
    @inflections = inflections.merge(original: word.to_s)
    @path = [word.to_sym]
  end

  private

  attr_reader :inflections
  attr_accessor :path

  def get_word_by_inflection(name)
    add_to_path(name)
    inflections.dig(*path)
  end

  def add_to_path(key)
    path << key
  end
end
