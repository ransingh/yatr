require 'spec_helper'
require 'simulation/command/turn_left'

describe Simulation::Command::TurnLeft do
  describe "#execute" do
    let(:executor) { double('CommandExecutor') }

    subject { Simulation::Command::TurnLeft.new(executor) }

    it "calls turn left command on the executor with no arguments" do
      expect(executor).to receive(:turn_left).once.with(no_args)

      subject.execute
    end
  end
end
