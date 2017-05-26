module Simulation

  class MovementCalculator

    def initialize position, direction, grid
      @position = position
      @direction = direction
      @grid = grid
    end

    def next_position
      if @direction.facing_east?
        position = @position.right
      elsif @direction.facing_west?
        position = @position.left
      elsif @direction.facing_north?
        position = @position.up
      elsif @direction.facing_south?
        position = @position.down
      end

      validate_position!(position)
      position
    end

    private

    def validate_position!(position)
      unless @grid.coordinates_valid?(position.x_coordinate, position.y_coordinate)
        raise Simulation::InvalidPositionError, "(#{position.x_coordinate},#{position.y_coordinate}) are out of grid(#{@grid})"
      end
    end

    def create_position(x_coordinate, y_coordinate)
      Simulation::Position.new(x_coordinate, y_coordinate)
    end

  end

end
