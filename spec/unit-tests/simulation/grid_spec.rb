require 'spec_helper'
require 'simulation/grid'

describe Simulation::Grid do

  subject { Simulation::Grid.new(x_dimension_size, y_dimension_size) }

  context ".new" do

    context "when invalid grid size is provided" do
      let(:x_dimension_size) { -5 }
      let(:y_dimension_size) { -5 }

      it "does not set up the grid for robot" do
        expect{ subject }.to raise_error
      end
    end
  end

  context "valid grid initialization" do
    let(:x_dimension_size) { 7 }
    let(:y_dimension_size) { 5 }

    it "grid returns the correct maximum north bounds" do
      expect(subject.maximum_north_bound).to eq(5)
    end

    it "grid returns the correct maximum south bounds" do
      expect(subject.maximum_south_bound).to eq(0)
    end

    it "grid returns the correct maximum west bounds" do
      expect(subject.maximum_west_bound).to eq(0)
    end

    it "grid returns the correct maximum east bounds" do
      expect(subject.maximum_east_bound).to eq(7)
    end
  end
end
