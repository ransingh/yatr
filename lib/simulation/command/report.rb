require 'simulation/command/base'

module Simulation
  module Command
    class Report < Base

      def execute
        executor.report
      end
    end
  end
end
