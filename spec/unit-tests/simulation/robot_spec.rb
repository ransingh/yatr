require 'spec_helper'
require 'simulation/grid'

require 'simulation/direction'

require 'simulation/robot'

describe Simulation::Robot do
  let(:logger) { double('logger') }
  let(:grid)   { Simulation::Grid.new(5,5) }

  subject { Simulation::Robot.new(grid) }

  describe "#place" do
    let(:facing_direction) { Simulation::Direction::NORTH }

    context "when the given position is not valid" do
      context "when x_coordinate beyond maximum west bound" do
        let(:x_coordinate) { -1 }
        let(:y_coordinate) { 2 }

        it "does not place robot" do
          expect{ subject.place(x_coordinate, y_coordinate, facing_direction) }.to \
            raise_error(
              Simulation::InvalidPositionError,
              "Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
           )
        end
      end

      context "when x_coordinate beyond maximum east bound" do
        let(:x_coordinate) { 6 }
        let(:y_coordinate) { 2 }

        it "does not place robot" do
          expect{ subject.place(x_coordinate, y_coordinate, facing_direction) }.to \
            raise_error(
              Simulation::InvalidPositionError,
              "Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
            )
        end
      end

      context "when y_coordinate is beyond maximum north bound" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 6 }

        it "does not place robot" do
          expect{ subject.place(x_coordinate, y_coordinate, facing_direction) }.to \
            raise_error(
              Simulation::InvalidPositionError,
              "Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
            )
        end
      end

      context "when y_coordinate is beyond maximum south bound" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { -1 }

        it "does not place robot" do
          expect{ subject.place(x_coordinate, y_coordinate, facing_direction) }.to \
            raise_error(
              Simulation::InvalidPositionError,
              "Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
            )
        end
      end
    end

    context "when the given position is valid" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 5 }

      it "places the robot" do
        subject.place(x_coordinate, y_coordinate, facing_direction)
        expect( subject.placed_correclty? ).to be_truthy
      end
    end
  end

  describe "#move" do

    context "when robot is not correctly placed" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 6 }
      let(:facing_direction) { Simulation::Direction::NORTH }

      it "will ignore the move command" do
        allow(Simulation).to receive(:logger).and_return(logger)
        expect(logger).to receive(:warn).with(/Ignoring command to move.*/)

        subject.move
      end
    end

    context "when robot is correctly placed" do
      before(:each) do
        subject.place(x_coordinate, y_coordinate, facing_direction)
      end

      context "and can move in the NORTH direction" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 4 }
        let(:facing_direction) { Simulation::Direction::NORTH }

        it "moves in that direction" do
          subject.move

          expect(subject.x_coordinate).to eq(x_coordinate)
          expect(subject.y_coordinate).to eq(y_coordinate + 1)
        end

        it "does not change its direction" do
          subject.move

          expect(subject.facing_direction).to eq(facing_direction)
        end
      end

      context "and can move in the SOUTH direction" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 4 }
        let(:facing_direction) { Simulation::Direction::SOUTH }

        it "moves in that direction" do
          subject.move

          expect(subject.x_coordinate).to eq(x_coordinate)
          expect(subject.y_coordinate).to eq(y_coordinate - 1)
        end

        it "does not change its direction" do
          subject.move

          expect(subject.facing_direction).to eq(facing_direction)
        end
      end

      context "and can move in the WEST direction" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 4 }
        let(:facing_direction) { Simulation::Direction::WEST }

        it "moves in that direction" do
          subject.move

          expect(subject.x_coordinate).to eq(x_coordinate - 1)
          expect(subject.y_coordinate).to eq(y_coordinate)
        end

        it "does not change its direction" do
          subject.move

          expect(subject.facing_direction).to eq(facing_direction)
        end
      end

      context "and can move in the WEST direction" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 4 }
        let(:facing_direction) { Simulation::Direction::EAST }

        it "moves in that direction" do
          subject.move

          expect(subject.x_coordinate).to eq(x_coordinate + 1)
          expect(subject.y_coordinate).to eq(y_coordinate)
        end

        it "does not change its direction" do
          subject.move

          expect(subject.facing_direction).to eq(facing_direction)
        end
      end

      shared_examples "cannot_move_with_current_direction" do
        it "does not move in that direction" do
          subject.move

          expect(subject.x_coordinate).to eq(x_coordinate)
          expect(subject.y_coordinate).to eq(y_coordinate)
        end

        it "does not change its direction" do
          subject.move

          expect(subject.facing_direction).to eq(facing_direction)
        end
      end

      context "cannot move in the NORTH direction" do
        let(:x_coordinate) { 2 }
        let(:y_coordinate) { 5 }
        let(:facing_direction) { Simulation::Direction::NORTH }

        it_behaves_like "cannot_move_with_current_direction"
      end

      context "cannot move in the EAST direction" do
        let(:x_coordinate) { 5 }
        let(:y_coordinate) { 3 }
        let(:facing_direction) { Simulation::Direction::EAST }

        it_behaves_like "cannot_move_with_current_direction"
      end

      context "cannot move in the SOUTH direction" do
        let(:x_coordinate) { 5 }
        let(:y_coordinate) { 0 }
        let(:facing_direction) { Simulation::Direction::SOUTH }

        it_behaves_like "cannot_move_with_current_direction"
      end

      context "cannot move in the WEST direction" do
        let(:x_coordinate) { 0 }
        let(:y_coordinate) { 4 }
        let(:facing_direction) { Simulation::Direction::WEST }

        it_behaves_like "cannot_move_with_current_direction"
      end

    end
  end

  describe "#turn_right" do
    context "when robot is not correctly placed" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 6 }

      it "will ignore the  turn right command" do
        allow(Simulation).to receive(:logger).and_return(logger)
        expect(logger).to receive(:warn).with(/Ignoring command to turn right.*/)

        subject.turn_right

      end
    end

    context "when robot is correctly placed" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 5 }


      before(:each) do
        subject.place(x_coordinate, y_coordinate, facing_direction)
      end

      context "and it is facing NORTH" do
        let(:facing_direction) { Simulation::Direction::NORTH }

        it "on turning right changes its direction to EAST" do
          subject.turn_right

          expect(subject.facing_direction).to eq(Simulation::Direction::EAST)
        end
      end

      context "and it is facing EAST" do
        let(:facing_direction) { Simulation::Direction::EAST }

        it "on turning right changes its direction to SOUTH" do
          subject.turn_right

          expect(subject.facing_direction).to eq(Simulation::Direction::SOUTH)
        end
      end

      context "and it is facing SOUTH" do
        let(:facing_direction) { Simulation::Direction::SOUTH }

        it "on turning right changes its direction to WEST" do
          subject.turn_right

          expect(subject.facing_direction).to eq(Simulation::Direction::WEST)
        end
      end

      context "and it is facing WEST" do
        let(:facing_direction) { Simulation::Direction::WEST }

        it "on turning right changes its direction to NORTH" do
          subject.turn_right

          expect(subject.facing_direction).to eq(Simulation::Direction::NORTH)
        end
      end
    end
  end

  describe "#turn_left" do
    context "when robot is not correctly placed" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 6 }
      let(:facing_direction) { Simulation::Direction::NORTH }

      it "will ignore the  turn left command" do
        allow(Simulation).to receive(:logger).and_return(logger)
        expect(logger).to receive(:warn).with(/Ignoring command to turn left.*/)
        subject.turn_left
      end
    end

    context "when the given position is valid" do
      let(:x_coordinate) { 2 }
      let(:y_coordinate) { 5 }


      before(:each) do
        subject.place(x_coordinate, y_coordinate, facing_direction)
      end

      context "and it is facing NORTH" do
        let(:facing_direction) { Simulation::Direction::NORTH }

        it "on turning right changes its direction to WEST" do
          subject.turn_left

          expect(subject.facing_direction).to eq(Simulation::Direction::WEST)
        end
      end

      context "and it is facing EAST" do
        let(:facing_direction) { Simulation::Direction::EAST }

        it "on turning right changes its direction to NORTH" do
          subject.turn_left

          expect(subject.facing_direction).to eq(Simulation::Direction::NORTH)
        end
      end

      context "and it is facing SOUTH" do
        let(:facing_direction) { Simulation::Direction::SOUTH }

        it "on turning right changes its direction to EAST" do
          subject.turn_left

          expect(subject.facing_direction).to eq(Simulation::Direction::EAST)
        end
      end

      context "and it is facing WEST" do
        let(:facing_direction) { Simulation::Direction::WEST }

        it "on turning right changes its direction to SOUTH" do
          subject.turn_left

          expect(subject.facing_direction).to eq(Simulation::Direction::SOUTH)
        end
      end
    end
  end

  describe "#report" do
    context "when robot is not correctly placed" do
      it "will ignore the report command" do
        allow(Simulation).to receive(:logger).and_return(logger)
        expect(logger).to receive(:warn).with(/Ignoring command to report.*/)

        subject.report
      end
    end

    context "when robot is correctly placed" do
      let(:x_coordinate)     { 2 }
      let(:y_coordinate)     { 5 }
      let(:facing_direction) { Simulation::Direction::WEST }
      let(:valid_position)   { double('Valid Position', :to_s => position) }

      before(:each) do
        subject.place(x_coordinate, y_coordinate, facing_direction)
      end

      it "will report" do
        expect(subject.report).to eq("#{x_coordinate},#{y_coordinate},#{facing_direction}")
      end
    end
  end
end
