module Simulation
  module Direction
    NORTH = "NORTH"
    SOUTH = "SOUTH"
    EAST  = "EAST"
    WEST  = "WEST"
    
    def rotate_left_from(direction)
      case direction
      when NORTH
        WEST
      when WEST
        SOUTH
      when SOUTH
        EAST
      when EAST
        NORTH
      end
    end

    def rotate_right_from(direction)
      case direction
      when NORTH
        EAST
      when EAST
        SOUTH
      when SOUTH
        WEST
      when WEST
        NORTH
      end
    end
  end
end
