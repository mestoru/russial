# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { described_class.new(word, inflections) }

  describe "cases" do
    let!(:word) { "ruby" }
    let!(:inflections) { RUBY_INFLECTIONS }

    describe "#nominative" do
      it { expect(subject.nominative).to eq "рубин" }
      it { expect(subject.n).to eq "рубин" }
    end

    describe "#genitive" do
      it { expect(subject.genitive).to eq "рубина" }
      it { expect(subject.g).to eq "рубина" }
    end

    describe "#dative" do
      it { expect(subject.dative).to eq "рубину" }
      it { expect(subject.d).to eq "рубину" }
    end

    describe "#accusative" do
      it { expect(subject.accusative).to eq "рубин" }
      it { expect(subject.a).to eq "рубин" }
    end

    describe "#instrumental" do
      it { expect(subject.instrumental).to eq "рубином" }
      it { expect(subject.i).to eq "рубином" }
    end

    describe "#prepositional" do
      it { expect(subject.prepositional).to eq "рубине" }
      it { expect(subject.p).to eq "рубине" }
    end
  end

  RUBY_INFLECTIONS = {
    ruby: {
      nominative: "рубин",
      genitive: "рубина",
      dative: "рубину",
      accusative: "рубин",
      instrumental: "рубином",
      prepositional: "рубине"
    }
  }.freeze
end
