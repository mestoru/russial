# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { described_class.new(word, dictionary: {}) }

  let!(:word) { "ruby" }

  before do
    described_class.configure do |c|
      c.i18n_scope = "russial_scope"
    end
  end

  describe "cases" do
    describe "#nominative" do
      it { expect(subject.nominative).to eq "рубин" }
    end

    describe "#genitive" do
      it { expect(subject.genitive).to eq "рубина" }
    end

    describe "#dative" do
      it { expect(subject.dative).to eq "рубину" }
    end

    describe "#accusative" do
      it { expect(subject.accusative).to eq "рубин" }
    end

    describe "#instrumental" do
      it { expect(subject.instrumental).to eq "рубином" }
    end

    describe "#prepositional" do
      it { expect(subject.prepositional).to eq "рубине" }
    end
  end
end
