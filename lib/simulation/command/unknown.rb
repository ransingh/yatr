require 'simulation/command/base'

module Simulation
  module Command
    class Unknown < Base

      def execute
        #no-op
      end
    end
  end
end
