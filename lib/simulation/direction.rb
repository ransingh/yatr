require 'simulation'

module Simulation
  class Direction

    attr_reader :facing_direction

    def initialize current_direction
      raise Simulation::InvalidDirectionError unless direction_valid?(current_direction)
      @facing_direction = current_direction
    end

    def turn_clockwise
      index_current_direction = all_directions.index(facing_direction)
      @facing_direction = all_directions.rotate(index_current_direction).rotate.first
    end

    def turn_anti_clockwise
      index_current_direction = all_directions.index(facing_direction)
      @facing_direction = all_directions.rotate(index_current_direction).rotate(-1).first
    end

    def facing_north?
      @facing_direction == 'NORTH'
    end

    def facing_east?
      @facing_direction == 'EAST'
    end

    def facing_west?
      @facing_direction == 'WEST'
    end

    def facing_south?
      @facing_direction == 'SOUTH'
    end

    def to_s
      @facing_direction
    end

    private

    def direction_valid? current_direction
      all_directions.include? current_direction
    end

    def all_directions
      %w{ NORTH NORTH_EAST EAST SOUTH_EAST SOUTH SOUTH_WEST WEST NORTH_WEST }
    end

  end
end
