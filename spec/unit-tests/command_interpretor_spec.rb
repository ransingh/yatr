require 'spec_helper'
require 'command_interpretor'

describe CommandInterpretor do
  let(:command_executor) { double('CommandExecutor') }

  subject(:command_interpretor) { CommandInterpretor.for(command_executor) }

  describe "#interpret" do
    context "when it is PLACE command string" do

      it "interprets it as a PLACE command to execute" do
        expect(subject.interpret("PLACE 0,0,NORTH")).to be_kind_of(::Simulation::Command::Place)
      end

      it "interprets the coordinates of the PLACE command correctly " do
        cmd = subject.interpret("PLACE 1,3,NORTH")

        expect(cmd.x).to be(1)
        expect(cmd.y).to be(3)
      end

      context "with facing direction" do

        subject { command_interpretor.interpret("PLACE 1,3,#{direction}").facing }

        context "as NORTH" do
          let(:direction) { "NORTH" }

          it { is_expected.to eq('NORTH') }
        end

        context "as SOUTH" do
          let(:direction) { "SOUTH" }

          it { is_expected.to eq('SOUTH') }
        end

        context "as WEST" do
          let(:direction) { "WEST" }

          it { is_expected.to eq('WEST') }
        end

        context "as EAST" do
          let(:direction) { "EAST" }

          it { is_expected.to eq('EAST') }
        end
      end
    end

    context "when it is MOVE command string" do
      it "interprets it as a MOVE command to execute" do
        expect(subject.interpret("MOVE")).to be_a ::Simulation::Command::Move
      end
    end

    context "when it is LEFT command string" do
      it "interprets it as a LEFT turn command to execute" do
        expect(subject.interpret("LEFT")).to be_a ::Simulation::Command::TurnLeft
      end
    end

    context "when it is RIGHT command string" do
      it "interprets it as a RIGHT turn command to execute" do
        expect(subject.interpret("RIGHT")).to be_a ::Simulation::Command::TurnRight
      end
    end

    context "when it is REPORT command string" do
      it "interprets it as a REPORT command to execute" do
        expect(subject.interpret("REPORT")).to be_a ::Simulation::Command::Report
      end
    end

    shared_examples_for "an invalid command string" do
      it "interprets it as a UNKNOWN command" do
        expect(subject.interpret(invalid_command_string)).to be_a ::Simulation::Command::Unknown
      end
    end

    [
      "PLACE 0,0,NRTH","PLACE 0,0,EAS","PLACE 0,0,STH",
      "PLACE 0,0,WES","MOV","LEFTT", "RIGHTT", "REPOR"
    ].each do |str|
      context "when it is an invalid command string like #{str}" do
        it_should_behave_like "an invalid command string" do
          let(:invalid_command_string) { "MOV" }
        end
      end
    end
  end
end
