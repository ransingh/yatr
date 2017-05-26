module Simulation

  class MovementCalculator

    def initialize position, direction, grid
      @position = position
      @direction = direction
      @grid = grid
    end

    def next_position
      if @direction.facing_east?
        x_coordinate, y_coordinate = @position.x_coordinate + 1, @position.y_coordinate
      elsif @direction.facing_west?
        x_coordinate, y_coordinate = @position.x_coordinate - 1, @position.y_coordinate
      elsif @direction.facing_north?
        x_coordinate, y_coordinate = @position.x_coordinate, @position.y_coordinate + 1
      elsif @direction.facing_south?
        x_coordinate, y_coordinate = @position.x_coordinate, @position.y_coordinate - 1
      end

      validate_direction!(x_coordinate, y_coordinate)
      create_position(x_coordinate, y_coordinate)
    end

    private

    def validate_direction!(x_coordinate, y_coordinate)
      unless @grid.coordinates_valid?(x_coordinate, y_coordinate)
        raise Simulation::InvalidPositionError, "(#{x_coordinate},#{y_coordinate}) are out of grid(#{@grid})"
      end
    end

    def create_position(x_coordinate, y_coordinate)
      Simulation::Position.new(x_coordinate, y_coordinate)
    end

  end

end
