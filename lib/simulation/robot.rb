require 'simulation'
require 'simulation/grid'
require 'simulation/position'
require 'simulation/direction'
require 'simulation/robot_direction'

module Simulation

  class Robot
    include Direction
    extend Forwardable

    def_delegators :@position, :x_coordinate, :y_coordinate
    def_delegator :@direction, :facing_direction

    def initialize(grid)
      @grid = grid
    end

    def place(x_coordinate, y_coordinate, facing_direction)
      unless @grid.coordinates_valid?(x_coordinate, y_coordinate)
        raise InvalidPositionError,"Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
      end
      @position = Position.new(x_coordinate, y_coordinate, facing_direction)
      @direction = RobotDirection.new(facing_direction)
    end

    def placed_correclty?
      !!@position
    end

    def move
      ensure_placed_correctly

      if next_move_valid?
        case facing_direction
        when Simulation::Direction::NORTH
          @position = Simulation::Position.new(x_coordinate, y_coordinate + 1, facing_direction)
        when Simulation::Direction::SOUTH
          @position = Simulation::Position.new(x_coordinate, y_coordinate - 1, facing_direction)
        when Simulation::Direction::WEST
          @position = Simulation::Position.new(x_coordinate - 1, y_coordinate, facing_direction)
        when Simulation::Direction::EAST
          @position = Simulation::Position.new(x_coordinate + 1, y_coordinate, facing_direction)
        else
          raise InvalidStateError, "Robot in invalid direction"
        end
      end
    end

    def turn_left
      ensure_placed_correctly
      @direction.turn_anti_clockwise
    end

    def turn_right
      ensure_placed_correctly
      @direction.turn_clockwise
    end

    def report
      unless placed_correclty?
        Simulation.logger.warn("Ignoring command to report as it is not positioned correctly.")
        return
      end

      $stdout.puts "  Output: #{@position}"
      "#{@position}"
    end

    private

    def ensure_placed_correctly
      raise Simulation::InvalidStateError, "Robot not placed correctly" unless placed_correclty?
    end

    def next_move_valid?
      case facing_direction
      when Simulation::Direction::NORTH
        @grid.coordinates_valid?(x_coordinate, y_coordinate + 1)
      when Simulation::Direction::EAST
        @grid.coordinates_valid?(x_coordinate + 1, y_coordinate)
      when Simulation::Direction::SOUTH
        @grid.coordinates_valid?(x_coordinate, y_coordinate - 1)
      when Simulation::Direction::WEST
        @grid.coordinates_valid?(x_coordinate - 1, y_coordinate)
      else
        false
      end
    end
  end
end
