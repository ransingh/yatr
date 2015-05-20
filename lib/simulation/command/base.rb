module Simulation
  module Command
    class Base
      attr_reader :executor

      def initialize(executor)
        @executor = executor
      end

      def execute
        raise "subclass to implement '#{__method__}' method"
      end

      def to_s
        "#{class_name} command"
      end
    end
  end
end
