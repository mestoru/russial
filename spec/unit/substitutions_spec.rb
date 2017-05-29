# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject do
    described_class.new(word,
                        dictionary: inflections,
                        substitutions: substitutions)
  end

  let!(:substitutions) { {} }
  let!(:word) { "многокомнатная квартира" }

  describe "substitutions" do
    let!(:inflections) { FLAT_INFLECTIONS }
    let!(:substitutions) { FLAT_SUBSTITUTIONS }

    it { expect(subject.dative).to eq "трёхкомнатной квартире" }
    it { expect(subject.instrumental).to eq "трёхкомнатной квартирой" }
  end

  FLAT_INFLECTIONS = {
      "многокомнатная квартира": {
          nominative: "___комнатная квартира",
          genitive: "___комнатной квартиры",
          dative: "___комнатной квартире",
          accusative: "___комнатную квартиру",
          instrumental: "___комнатной квартирой",
          prepositional: "___комнатной квартире"
      }
  }.freeze

  FLAT_SUBSTITUTIONS = { "___" => "трёх" }.freeze
end
