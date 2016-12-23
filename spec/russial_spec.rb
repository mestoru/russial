# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { described_class.new(word, inflections) }

  describe "cases" do
    let!(:word) { "ruby" }
    let!(:inflections) { RUBY_INFLECTIONS }

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
      end
    end
  end

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
