require 'spec_helper'
require 'simulation/position'

describe Simulation::Position do

  let(:x_coordinate) { 5 }
  let(:y_coordinate) { 5 }

  describe '#up' do
    subject { described_class.new(x_coordinate, y_coordinate).up }

    it "increments y_coordinate by 1" do
      expect(subject.y_coordinate).to eq y_coordinate + 1
    end

    it "does not change the x_coordinate" do
      expect(subject.x_coordinate).to eq x_coordinate
    end
  end

  describe '#down' do
    subject { described_class.new(x_coordinate, y_coordinate).down }

    it "decrements y_coordinate by 1" do
      expect(subject.y_coordinate).to eq y_coordinate - 1
    end

    it "does not change the x_coordinate" do
      expect(subject.x_coordinate).to eq x_coordinate
    end
  end

  describe '#right' do
    subject { described_class.new(x_coordinate, y_coordinate).right }

    it "increments x_coordinate by 1" do
      expect(subject.x_coordinate).to eq x_coordinate + 1
    end

    it "does not change the y_coordinate" do
      expect(subject.y_coordinate).to eq y_coordinate
    end
  end

  describe '#left' do
    subject { described_class.new(x_coordinate, y_coordinate).left }

    it "decrements x_coordinate by 1" do
      expect(subject.x_coordinate).to eq x_coordinate - 1
    end

    it "does not change the y_coordinate" do
      expect(subject.y_coordinate).to eq y_coordinate
    end
  end
end
