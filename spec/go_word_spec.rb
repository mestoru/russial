# frozen_string_literal: true
require "i18n"
require "spec_helper"

describe Russial do
  subject { described_class.new(word) }

  context "with I18n" do

    let!(:word) { "идти" }

    before do
      I18n.tap do |c|
        c.available_locales = [:ru]
        c.locale = :ru
        c.load_path = ["spec/fixtures/words.yml"]
      end
    end

    describe "cases" do
      describe "#future" do
        let!(:result) { "Фестиваль пройдёт уже завтра" }

        it { expect("Фестиваль #{subject.future} уже завтра").to eq result }
      end

      context "when past" do
        before do
          subject.past
        end

        context "when singular" do
          before do
            subject.singular
          end

          describe "#male" do
            let!(:result) { "Грозовой фронт прошёл мимо" }

            it { expect("Грозовой фронт #{subject.male} мимо").to eq result }
          end

          describe "#female" do
            let!(:result) { "Она прошла, как каравелла" }

            it { expect("Она #{subject.female}, как каравелла").to eq result }
          end
        end

        describe "#plural" do
          let!(:result) { "Неравнодушные не прошли мимо" }

          it { expect("Неравнодушные не #{subject.plural} мимо").to eq result }
        end
      end

      describe "#present" do
        let!(:result) { "Любовь проходит, боль остаётся" }

        it { expect("Любовь #{subject.present}, боль остаётся").to eq result }
      end
    end

    describe "default_scope" do
      it { expect(subject.send(:default_scope)).to be_empty }
    end
  end
end
