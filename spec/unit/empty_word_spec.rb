# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { described_class.new(word, dictionary: {}) }

  let!(:word) { "" }

  before do
    described_class.configure do |c|
      c.i18n_scope = "russial_scope"
    end
  end

  it do
    expect { subject }.to_not raise_error
  end
end
