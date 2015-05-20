require 'spec_helper'
require 'simulation/command/move'

describe Simulation::Command::Move do
  describe "#execute" do
    let(:executor) { double('CommandExecutor') }

    subject { Simulation::Command::Move.new(executor) }

    it "calls move command on the executor with no arguments" do
      expect(executor).to receive(:move).once.with(no_args)

      subject.execute
    end
  end
end
