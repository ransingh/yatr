
module Simulation
  class Position
    attr_reader :x_coordinate, :y_coordinate

    def initialize(x_coordinate, y_coordinate)
      @x_coordinate = x_coordinate
      @y_coordinate = y_coordinate
    end

    def up
      self.class.new(@x_coordinate, @y_coordinate + 1)
    end

    def down
      self.class.new(@x_coordinate, @y_coordinate - 1)
    end

    def right
      self.class.new(@x_coordinate + 1, @y_coordinate)
    end

    def left
      self.class.new(@x_coordinate - 1, @y_coordinate)
    end

    def to_s
      "#{@x_coordinate},#{@y_coordinate}"
    end
  end
end # Position
