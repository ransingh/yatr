require 'simulation/direction'

module Simulation
  class Position
    attr_reader :x_coordinate, :y_coordinate, :facing_direction

    def initialize(x_coordinate, y_coordinate, facing_direction)
      @x_coordinate     = x_coordinate
      @y_coordinate     = y_coordinate
      @facing_direction = facing_direction
    end

    def to_s
      "#{@x_coordinate},#{@y_coordinate},#{@facing_direction}"
    end
  end
end # Position
