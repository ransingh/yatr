require 'simulation/command/base'

module Simulation
  module Command
    class Move < Base

      def execute
        executor.move
      end
    end
  end
end
