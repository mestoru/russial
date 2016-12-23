# frozen_string_literal: true
require "russial/version"

class Russial
  def initialize(word, dictionary)
    @dictionary = dictionary[word.to_sym]
    @path = []
    generate_methods
  end

  private

  attr_reader :dictionary
  attr_accessor :path, :default_path

  def keys
    @keys ||= extract_keys(dictionary).flatten(1)
  end

  def extract_keys(hash, depth = 0)
    hash.map do |k, v|
      if v.is_a? Hash
        extract_keys(v, depth.succ) << [depth, k]
      else
        [depth, k]
      end
    end
  end

  def default_scope
    @default_path ||= keys.reverse.to_h.values[0...-1]
  end

  def generate_methods
    keys.each do |_, key|
      define_singleton_method(key) do
        path << key
        get
      end
    end
  end

  def get
    case (foo = result)
    when Hash
      self
    when String
      reset_path
      foo
    end
  end

  def reset_path
    self.path = []
  end

  def result
    dictionary.dig(*path) || dictionary.dig(*default_scope, path.last)
  end
end
