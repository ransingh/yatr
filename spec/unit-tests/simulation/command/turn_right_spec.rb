require 'spec_helper'
require 'simulation/command/turn_right'

describe Simulation::Command::TurnRight do
  describe "#execute" do
    let(:executor) { double('CommandExecutor') }

    subject { Simulation::Command::TurnRight.new(executor) }

    it "calls turn right command on the executor with no arguments" do
      expect(executor).to receive(:turn_right).once.with(no_args)

      subject.execute
    end
  end
end
