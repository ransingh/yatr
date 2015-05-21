require 'spec_helper'
require 'simulation/command/place'

describe Simulation::Command::Place do
  describe "#execute" do
    let(:x_coordinate)     { 4 }
    let(:y_coordinate)     { 2 }
    let(:facing_direction) { "NORTH" }
    let(:executor)         { double('CommandExecutor') }

    subject { Simulation::Command::Place.new(executor, x_coordinate, y_coordinate, facing_direction) }

    it "calls place command on the executor with (x,y) coordinates and facing direction" do
      expect(executor).to receive(:place).once.with(x_coordinate, y_coordinate, facing_direction)

      subject.execute
    end
  end
end
