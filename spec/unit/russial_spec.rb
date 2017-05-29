# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { described_class.new(word, dictionary: inflections) }

  let!(:inflections) { RUBY_INFLECTIONS }
  let!(:word) { "ruby" }

  before do
    described_class.configure do |c|
      c.aliases = ALIASES
    end
  end

  describe "cases" do
    context "when singular" do
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

    context "when plural" do
      describe "cases" do
        before do
          subject.plural
        end

        describe "#nominative" do
          it { expect(subject.nominative).to eq "рубины" }
        end

        describe "#genitive" do
          it { expect(subject.genitive).to eq "рубинов" }
        end

        describe "#dative" do
          it { expect(subject.dative).to eq "рубинам" }
        end

        describe "#accusative" do
          it { expect(subject.accusative).to eq "рубины" }
        end

        describe "#instrumental" do
          it { expect(subject.instrumental).to eq "рубинами" }
        end

        describe "#prepositional" do
          it { expect(subject.prepositional).to eq "рубинах" }
        end

        it "handles two cases from same scope in a row" do
          expect(subject.nominative).to eq "рубины"
          expect(subject.genitive).to eq "рубинов"
        end
      end

      context "when multiple plural call" do
        before do
          3.times { subject.plural }
        end

        describe "#nominative" do
          it { expect(subject.nominative).to eq "рубины" }
        end
      end
    end

    context "when aliases" do
      describe "cases" do
        describe "#n" do
          it { expect(subject.n).to eq "рубин" }
        end

        describe "#g" do
          it { expect(subject.g).to eq "рубина" }
        end

        describe "#d" do
          it { expect(subject.d).to eq "рубину" }
        end

        describe "#a" do
          it { expect(subject.a).to eq "рубин" }
        end

        describe "#i" do
          it { expect(subject.i).to eq "рубином" }
        end

        describe "#p" do
          it { expect(subject.p).to eq "рубине" }
        end
      end
    end

    context "when dictionary is nil" do
      let!(:inflections) { nil }

      it { expect { subject }.to_not raise_error }
    end

    describe "#reset" do
      before do
        subject.plural
      end

      let(:path_after_reset) { subject.reset.send(:path) }

      it "resets state" do
        expect(path_after_reset).to be_empty
      end
    end
  end

  describe "default config" do
    let!(:config) { described_class.reset }

    it { expect(config.aliases).to eq({}) }
    it { expect(config.i18n_scope).to eq :russial }
  end

  describe "missing methods" do
    it { expect("Превосходный #{subject}!").to eq "Превосходный ruby!" }
    it { expect(subject.to_sym).to eq :ruby }
    it { expect(subject.respond_to?(:to_sym)).to be_truthy }
  end

  ALIASES = {
    n: :nominative,
    g: :genitive,
    d: :dative,
    a: :accusative,
    i: :instrumental,
    p: :prepositional
  }.freeze

  RUBY_INFLECTIONS = {
    ruby: {
      singular: {
        nominative: "рубин",
        genitive: "рубина",
        dative: "рубину",
        accusative: "рубин",
        instrumental: "рубином",
        prepositional: "рубине"
      },
      plural: {
        nominative: "рубины",
        genitive: "рубинов",
        dative: "рубинам",
        accusative: "рубины",
        instrumental: "рубинами",
        prepositional: "рубинах"
      }
    }
  }.freeze
end
