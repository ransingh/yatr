require 'spec_helper'
require 'simulation/command/unknown'

describe Simulation::Command::Unknown do
  describe "#execute" do
    let(:executor) { double('CommandExecutor') }

    subject { Simulation::Command::Unknown.new(executor) }

    it "calls no command on the executor" do
      expect(executor).not_to receive(:move)
      expect(executor).not_to receive(:turn_right)
      expect(executor).not_to receive(:turn_left)
      expect(executor).not_to receive(:report)
      expect(executor).not_to receive(:place)
      subject.execute
    end
  end
end
