require 'simulation/command/base'

module Simulation
  module Command
    class TurnLeft < Base

      def execute
        executor.turn_left
      end
    end
  end
end
