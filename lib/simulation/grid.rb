require 'simulation'

# Grid models the table top on which robot can move.
# Grid can queried about its north, east, south and west bounds
module Simulation
  class Grid
    def initialize(x_dimension_size, y_dimension_size)
      raise ArgumentError, "#{x_dimension_size} should be a positive value" unless x_dimension_size > 0
      raise ArgumentError, "#{y_dimension_size} should be a positive value" unless y_dimension_size > 0
      @x_dimension_size = x_dimension_size
      @y_dimension_size = y_dimension_size
    end

    def maximum_north_bound
      @y_dimension_size
    end

    def maximum_south_bound
      0
    end

    def maximum_west_bound
      0
    end

    def maximum_east_bound
      @x_dimension_size
    end

    def coordinates_valid? x_coordinate, y_coordinate
      (maximum_west_bound..maximum_east_bound) === x_coordinate &&
      (maximum_south_bound..maximum_north_bound) === y_coordinate
    end

    def to_s
      "East-West: (#{maximum_west_bound},#{maximum_east_bound}) - North-South: (#{maximum_north_bound},#{maximum_south_bound})"
    end
  end
end
