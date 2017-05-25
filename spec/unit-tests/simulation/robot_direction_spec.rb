require 'spec_helper'
require 'simulation/robot_direction'

describe Simulation::RobotDirection do
  DIRECTIONS = %w{ NORTH NORTH_EAST EAST SOUTH_EAST SOUTH SOUTH_WEST WEST NORTH_WEST }

  describe '.new' do

    context 'when the current direction is invalid' do

      it "raises invalid state error" do
        expect{ described_class.new('blah') }.to raise_error Simulation::InvalidDirectionError
      end

    end

    %w{ NORTH NORTH_EAST EAST SOUTH_EAST SOUTH SOUTH_WEST WEST NORTH_WEST }.each do |direction|
      context "when the current direction is #{direction}" do
        it "does not raise invalid state error" do
          expect { described_class.new(direction) }.not_to raise_error
        end
      end
    end
  end

  context 'on turning clockwise' do

    shared_examples 'turn_clockwise' do |initial_direction, next_direction|
      context "when direction is #{initial_direction}" do
        let(:initial_direction) { initial_direction }
        let(:next_direction) { next_direction }

        subject { described_class.new(initial_direction) }

        it "next direction is #{next_direction}" do
          subject.turn_clockwise
          expect(subject.facing_direction).to eq(next_direction)
        end

      end

    end

    DIRECTIONS.zip(DIRECTIONS.rotate).each do |initial_direction, next_direction|
      it_behaves_like 'turn_clockwise', initial_direction, next_direction
    end

  end

  context 'on turning anti-clockwise' do

    shared_examples 'turn_anti_clockwise' do |initial_direction, next_direction|
      context "when direction is #{initial_direction}" do
        let(:initial_direction) { initial_direction }
        let(:next_direction) { next_direction }

        subject { described_class.new(initial_direction) }

        it "next direction is #{next_direction}" do
          subject.turn_anti_clockwise
          expect(subject.facing_direction).to eq(next_direction)
        end

      end

    end

    DIRECTIONS.zip(DIRECTIONS.rotate(-1)).each do |initial_direction, next_direction|
      it_behaves_like 'turn_anti_clockwise', initial_direction, next_direction
    end

  end

end
