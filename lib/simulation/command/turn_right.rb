require 'simulation/command/base'

module Simulation
  module Command
    class TurnRight < Base

      def execute
        executor.turn_right
      end
    end
  end
end
