require 'simulation/grid'
require 'simulation/position'
require 'simulation/direction'

module Simulation
  class InvalidPositionError < StandardError; end

  class Robot
    include Direction
    extend Forwardable

    def_delegators :@position, :x_coordinate, :y_coordinate, :facing_direction

    def initialize(grid)
      @grid = grid
    end

    def place(x_coordinate, y_coordinate, facing_direction)
      unless valid_placement?(x_coordinate, y_coordinate, facing_direction)
        raise InvalidPositionError,"Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
      end
      @position = Position.new(x_coordinate, y_coordinate, facing_direction)
    end

    def placed_correclty?
      !!@position
    end

    def move
      unless placed_correclty?
        Simulation.logger.warn("Ignoring command to move as it is not positioned correctly.")
        return
      end

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
      unless placed_correclty?
        Simulation.logger.warn("Ignoring command to turn left as it is not positioned correctly.")
        return
      end

      new_facing_direction = rotate_left_from(facing_direction)
      @position = Simulation::Position.new(x_coordinate, y_coordinate, new_facing_direction)
    end

    def turn_right
      unless placed_correclty?
        Simulation.logger.warn("Ignoring command to turn right as it is not positioned correctly.")
        return
      end
      new_facing_direction = rotate_right_from(facing_direction)
      @position = Simulation::Position.new(x_coordinate, y_coordinate, new_facing_direction)
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

    def valid_placement?(x, y, facing_direction)
      return false unless x_coordinate_within_bounds?(x)
      return false unless y_coordinate_within_bounds?(y)
      return false unless facing_direction_valid?(facing_direction)
      return true
    end

    def x_coordinate_within_bounds?(x_coordinate)
      x_coordinate >= @grid.maximum_west_bound && x_coordinate <= @grid.maximum_east_bound
    end

    def y_coordinate_within_bounds?(y_coordinate)
      y_coordinate >= @grid.maximum_south_bound && y_coordinate <= @grid.maximum_north_bound
    end

    def facing_direction_valid?(facing_direction)
      facing_direction[/^(#{Direction::NORTH}|#{Direction::EAST}|#{Direction::WEST}|#{Direction::SOUTH})$/]
    end

    def next_move_valid?
      case facing_direction
      when Simulation::Direction::NORTH
        y_coordinate + 1 <= @grid.maximum_north_bound
      when Simulation::Direction::EAST
        x_coordinate + 1 <= @grid.maximum_east_bound
      when Simulation::Direction::SOUTH
        y_coordinate - 1 >= @grid.maximum_south_bound
      when Simulation::Direction::WEST
        x_coordinate - 1 >= @grid.maximum_west_bound
      else
        false
      end
    end
  end
end
