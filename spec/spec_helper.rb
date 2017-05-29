# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pry"
require "i18n"
require "simplecov"

I18n.tap do |c|
  c.available_locales = [:ru]
  c.locale = :ru
  c.load_path = ["spec/fixtures/words.yml"]
end

SimpleCov.start

require "russial"
