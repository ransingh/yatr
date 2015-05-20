require 'spec_helper'
require 'simulation/command/report'

describe Simulation::Command::Report do
  describe "#execute" do
    let(:executor) { double('CommandExecutor') }

    subject { Simulation::Command::Report.new(executor) }

    it "calls report command on the executor with no arguments" do
      expect(executor).to receive(:report).once.with(no_args)

      subject.execute
    end
  end
end
