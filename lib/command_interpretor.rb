require 'simulation'
require 'simulation/command/move'
require 'simulation/command/place'
require 'simulation/command/report'
require 'simulation/command/turn_left'
require 'simulation/command/turn_right'
require 'simulation/command/unknown'

class CommandInterpretor
  attr_accessor :command_executor

  def self.for(command_executor)
    self.new(command_executor)
  end

  def initialize(command_executor)
    @command_executor = command_executor
  end

  def interpret(command_str)
    convert_to_command(command_str)
  end

  private

  def convert_to_command(command_str)
    case command_str
    when /^PLACE \d+\,\d+\,(NORTH|SOUTH|EAST|WEST)$/
      match_data = command_str.match(/^PLACE (?<x>\d+)\,(?<y>\d+)\,(?<dir>NORTH|SOUTH|EAST|WEST)$/)
      Simulation::Command::Place.new(
        command_executor,
        match_data["x"].to_i,
        match_data["y"].to_i,
        match_data["dir"]
      )
    when /^MOVE$/
      Simulation::Command::Move.new(command_executor)
    when /^LEFT$/      
      Simulation::Command::TurnLeft.new(command_executor)
    when /^RIGHT$/
      Simulation::Command::TurnRight.new(command_executor)
    when /^REPORT$/
      Simulation::Command::Report.new(command_executor)
    else
      Simulation.logger.error("Invalid command: #{command_str}. Ready for next command.")
      Simulation::Command::Unknown.new(command_executor)
    end
  end
end
