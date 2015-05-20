require 'simulation/command/base'

module Simulation
  module Command
    class Place < Base
      attr_reader :x, :y, :facing

      def initialize(executor, x, y, facing)
        super(executor)
        @x = x
        @y = y
        @facing = facing
      end

      def execute
        executor.place(x, y, facing)
      end
    end
  end
end
