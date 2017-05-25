module Simulation
  module Direction
    NORTH = "NORTH"
    NORTH_EAST = "NORTH_EAST"
    EAST  = "EAST"
    SOUTH_EAST = "SOUTH_EAST"
    SOUTH = "SOUTH"
    SOUTH_WEST = "SOUTH_WEST"
    WEST  = "WEST"
    NORTH_WEST = "NORTH_WEST"

    DIRECTIONS = [
      NORTH,
      NORTH_EAST,
      EAST,
      SOUTH_EAST,
      SOUTH,
      SOUTH_WEST,
      WEST,
      NORTH_WEST
    ]

    def rotate_left_from(direction)
      index_current_direction = DIRECTIONS.index(direction)
      DIRECTIONS.rotate(index_current_direction).rotate(-1).first
    end

    def rotate_right_from(direction)
      index_current_direction = DIRECTIONS.index(direction)
      DIRECTIONS.rotate(index_current_direction).rotate.first
    end

    def direction_valid? direction
      DIRECTIONS.include? direction
    end
  end
end
