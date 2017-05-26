require 'spec_helper'
require 'simulation'
require 'simulation/grid'
require 'simulation/position'
require 'simulation/direction'
require 'simulation/movement_calculator'

describe Simulation::MovementCalculator do
  let(:grid_x_coordinate_bound) { 5 }
  let(:grid_y_coordinate_bound) { 5 }
  let(:grid) { Simulation::Grid.new(grid_x_coordinate_bound, grid_y_coordinate_bound) }

  subject { described_class.new(current_position, current_direction, grid) }

  describe '#next_move' do
    context 'for valid moves' do
      let(:x_coordinate) { 1 }
      let(:y_coordinate) { 1 }
      let(:current_position) { Simulation::Position.new(x_coordinate, y_coordinate) }

      context 'when facing east direction' do
        let(:current_direction) { Simulation::Direction.new('EAST') }

        it 'increments the x coordinate by 1' do
          next_position = subject.next_position
          expect(next_position.x_coordinate).to eq(current_position.x_coordinate + 1)
        end

        it 'does not change y coordinate' do
          next_position = subject.next_position
          expect(next_position.y_coordinate).to eq(current_position.y_coordinate)
        end
      end

      context 'when facing west direction' do
        let(:current_direction) { Simulation::Direction.new('WEST') }

        it 'decrements the x coordinate by 1' do
          next_position = subject.next_position
          expect(next_position.x_coordinate).to eq(current_position.x_coordinate - 1)
        end

        it 'does not change y coordinate' do
          next_position = subject.next_position
          expect(next_position.y_coordinate).to eq(current_position.y_coordinate)
        end
      end

      context 'when facing north direction' do
        let(:current_direction) { Simulation::Direction.new('NORTH') }

        it 'increments the y coordinate by 1' do
          next_position = subject.next_position
          expect(next_position.y_coordinate).to eq(current_position.y_coordinate + 1)
        end

        it 'does not change x coordinate' do
          next_position = subject.next_position
          expect(next_position.x_coordinate).to eq(current_position.x_coordinate)
        end
      end

      context 'when facing south direction' do
        let(:current_direction) { Simulation::Direction.new('SOUTH') }

        it 'decrements the y coordinate by 1' do
          next_position = subject.next_position
          expect(next_position.y_coordinate).to eq(current_position.y_coordinate - 1)
        end

        it 'does not change x coordinate' do
          next_position = subject.next_position
          expect(next_position.x_coordinate).to eq(current_position.x_coordinate)
        end
      end
    end

    context 'invalid moves' do
      context 'when facing east direction' do
        let(:x_coordinate) { 5 }
        let(:y_coordinate) { 1 }
        let(:current_position) { Simulation::Position.new(x_coordinate, y_coordinate) }
        let(:current_direction) { Simulation::Direction.new('EAST') }

        it 'raise invalid position error' do
          expect { subject.next_position }.to raise_error Simulation::InvalidPositionError
        end
      end

      context 'when facing west direction' do
        let(:x_coordinate) { 0 }
        let(:y_coordinate) { 1 }
        let(:current_position) { Simulation::Position.new(x_coordinate, y_coordinate) }
        let(:current_direction) { Simulation::Direction.new('WEST') }

        it 'raise invalid position error' do
          expect { subject.next_position }.to raise_error Simulation::InvalidPositionError
        end
      end

      context 'when facing north direction' do
        let(:x_coordinate) { 1 }
        let(:y_coordinate) { 5 }
        let(:current_position) { Simulation::Position.new(x_coordinate, y_coordinate) }
        let(:current_direction) { Simulation::Direction.new('NORTH') }

        it 'raise invalid position error' do
          expect { subject.next_position }.to raise_error Simulation::InvalidPositionError
        end
      end

      context 'when facing south direction' do
        let(:x_coordinate) { 1 }
        let(:y_coordinate) { 0 }
        let(:current_position) { Simulation::Position.new(x_coordinate, y_coordinate) }
        let(:current_direction) { Simulation::Direction.new('SOUTH') }

        it 'raise invalid position error' do
          expect { subject.next_position }.to raise_error Simulation::InvalidPositionError
        end
      end
    end

  end

end
