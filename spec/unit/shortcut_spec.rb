# frozen_string_literal: true
require "spec_helper"

describe Russial do
  subject { Russial("foo", dictionary: { foo: {}}) }

  describe "shortcut" do
    it { expect(subject).to be_instance_of described_class }
  end
end
