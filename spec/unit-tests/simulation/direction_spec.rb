require 'spec_helper'
require 'simulation/direction'

describe Simulation::Direction  do
  let(:navigable_thing) do
    Class.new do
      include Simulation::Direction
    end
  end

  shared_examples 'turn_clockwise' do |initial_direction, next_direction|

    context "when direction is #{initial_direction}" do
      let(:initial_direction) { initial_direction }
      let(:next_direction) { next_direction }

      it "next direction is #{next_direction}" do
        expect(navigable_thing.new.rotate_right_from(initial_direction)).to eq(next_direction)
      end

    end

  end

  shared_examples 'turn_counter_clockwise' do |initial_direction, next_direction|

    context "when direction is #{initial_direction}" do
      let(:initial_direction) { initial_direction }
      let(:next_direction) { next_direction }

      it "next direction is #{next_direction}" do
        expect(navigable_thing.new.rotate_left_from(initial_direction)).to eq(next_direction)
      end

    end

  end

  Simulation::Direction::DIRECTIONS.zip(Simulation::Direction::DIRECTIONS.rotate).each do |initial_direction, next_direction|
    it_behaves_like 'turn_clockwise', initial_direction, next_direction
  end

  Simulation::Direction::DIRECTIONS.zip(Simulation::Direction::DIRECTIONS.rotate(-1)).each do |initial_direction, next_direction|
    it_behaves_like 'turn_counter_clockwise', initial_direction, next_direction
  end

  context '#direction_valid?' do
    context 'when the direction is not valid' do
      let(:given_direction) { 'blah' }

      it "returns false" do
        expect(navigable_thing.new.direction_valid?(given_direction)).to be_falsey
      end

    end

    context 'when the direction is valid' do
      let(:given_direction) do
        [
          'NORTH',
          'NORTH_EAST',
          'EAST',
          'SOUTH_EAST',
          'SOUTH',
          'SOUTH_WEST',
          'WEST',
          'NORTH_WEST'
        ].shuffle.first
      end

      it "returns true" do
        expect(navigable_thing.new.direction_valid?(given_direction)).to be_truthy
      end

    end
  end


end
