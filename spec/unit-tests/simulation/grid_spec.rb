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

  context '#coordinates_valid?' do
    let(:x_dimension_size) { 7 }
    let(:y_dimension_size) { 5 }

    context 'when x coordinate is valid' do
      let(:x_coordinate) { 3 }

      context 'y_coordinate is outside the west bound of grid' do
        let(:y_coordinate) { y_dimension_size + 1 }

        it 'return false' do
          expect(subject
          .coordinates_valid?(x_coordinate, y_coordinate)).to be_falsey
        end
      end

      context 'y_coordinate is outside the east bound of grid' do
        let(:y_coordinate) { - 1 }

        it 'return false' do
          expect(subject
          .coordinates_valid?(x_coordinate, y_coordinate)).to be_falsey
        end

      end

    end

    context 'when y coordinate is valid' do

      let(:y_coordinate) { 4 }

      context 'x_coordinate is outside the north bound of grid' do
        let(:x_coordinate) { x_dimension_size + 1 }

        it 'return false' do
          expect(subject
          .coordinates_valid?(x_coordinate, y_coordinate)).to be_falsey
        end

      end

      context 'x_coordinate is outside the south bound of grid' do
        let(:x_coordinate) { -1 }

        it 'return false' do
          expect(subject
          .coordinates_valid?(x_coordinate, y_coordinate)).to be_falsey
        end

      end

    end

    context 'when x and y coordinates are valid' do
      let(:y_coordinate) { y_dimension_size - 1 }
      let(:x_coordinate) { x_dimension_size - 1 }

      it 'return true' do
        expect(subject.coordinates_valid?(x_coordinate, y_coordinate)).to be_truthy
      end

    end

    context 'when x and y coordinates are on the north east corner of grid' do
      let(:y_coordinate) { y_dimension_size }
      let(:x_coordinate) { x_dimension_size }

      it 'return true' do
        expect(subject.coordinates_valid?(x_coordinate, y_coordinate)).to be_truthy
      end

    end

  end

end
