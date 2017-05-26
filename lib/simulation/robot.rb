require 'simulation'
require 'simulation/grid'
require 'simulation/position'
require 'simulation/direction'
require 'simulation/movement_calculator'

module Simulation

  class Robot
    extend Forwardable

    def_delegators :@position, :x_coordinate, :y_coordinate
    def_delegator :@direction, :facing_direction

    def initialize(grid)
      @grid = grid
    end

    def place(x_coordinate, y_coordinate, facing_direction)
      unless can_place?(x_coordinate, y_coordinate)
        raise InvalidPositionError,"Cannot place at (#{x_coordinate},#{y_coordinate}) facing #{facing_direction}."
      end
      @position = Position.new(x_coordinate, y_coordinate)
      @direction = Direction.new(facing_direction)
    end

    def move
      ensure_placed_correctly
      movement_calculator = Simulation::MovementCalculator.new(@position, @direction, @grid)
      @position = movement_calculator.next_position
    rescue Simulation::InvalidPositionError => ipe
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

      $stdout.puts "  Output: #{@position}, #{@direction}"
      "#{@position},#{@direction}"
    end

    private

    def placed_correclty?
      !!@position
    end

    def can_place? x_coordinate, y_coordinate
      @grid.coordinates_valid?(x_coordinate, y_coordinate)
    end

    def ensure_placed_correctly
      raise Simulation::InvalidStateError, "Robot not placed correctly" unless placed_correclty?
    end
  end
end
