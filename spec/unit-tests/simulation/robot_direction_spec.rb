require 'spec_helper'
require 'simulation/robot_direction'

describe Simulation::RobotDirection do
  DIRECTIONS = %w{ NORTH NORTH_EAST EAST SOUTH_EAST SOUTH SOUTH_WEST WEST NORTH_WEST }

  describe '.new' do

    context 'when the current direction is invalid' do

      it "raises invalid state error" do
        expect{ described_class.new('blah') }.to raise_error Simulation::InvalidDirectionError
      end

    end

    %w{ NORTH NORTH_EAST EAST SOUTH_EAST SOUTH SOUTH_WEST WEST NORTH_WEST }.each do |direction|
      context "when the current direction is #{direction}" do
        it "does not raise invalid state error" do
          expect { described_class.new(direction) }.not_to raise_error
        end
      end
    end
  end


  describe "#facing_north?" do
    subject { described_class.new(current_direction).facing_north?  }

    context 'when facing NORTH' do
      let(:current_direction) { 'NORTH' }

      it { is_expected.to be_truthy }
    end

    context 'when not facing NORTH' do
      let(:current_direction) { DIRECTIONS.select{|d| d !='NORTH'}.shuffle.first }

      it { is_expected.to be_falsey }
    end

  end

  describe "#facing_east?" do
    subject { described_class.new(current_direction).facing_east?  }

    context 'when facing EAST' do
      let(:current_direction) { 'EAST' }

      it { is_expected.to be_truthy }
    end

    context 'when not facing EAST' do
      let(:current_direction) { DIRECTIONS.select{|d| d !='EAST'}.shuffle.first }

      it { is_expected.to be_falsey }
    end

  end

  describe "#facing_west?" do
    subject { described_class.new(current_direction).facing_west?  }

    context 'when facing WEST' do
      let(:current_direction) { 'WEST' }

      it { is_expected.to be_truthy }
    end

    context 'when not facing WEST' do
      let(:current_direction) { DIRECTIONS.select{|d| d !='WEST'}.shuffle.first }

      it { is_expected.to be_falsey }
    end

  end

  describe "#facing_south?" do
    subject { described_class.new(current_direction).facing_south?  }

    context 'when facing SOUTH' do
      let(:current_direction) { 'SOUTH' }

      it { is_expected.to be_truthy }
    end

    context 'when not facing SOUTH' do
      let(:current_direction) { DIRECTIONS.select{|d| d !='SOUTH'}.shuffle.first }

      it { is_expected.to be_falsey }
    end

  end

  context 'on turning clockwise' do

    shared_examples 'turn_clockwise' do |initial_direction, next_direction|
      context "when direction is #{initial_direction}" do
        let(:initial_direction) { initial_direction }
        let(:next_direction) { next_direction }

        subject { described_class.new(initial_direction) }

        it "next direction is #{next_direction}" do
          subject.turn_clockwise
          expect(subject.facing_direction).to eq(next_direction)
        end

      end

    end

    DIRECTIONS.zip(DIRECTIONS.rotate).each do |initial_direction, next_direction|
      it_behaves_like 'turn_clockwise', initial_direction, next_direction
    end

  end

  context 'on turning anti-clockwise' do

    shared_examples 'turn_anti_clockwise' do |initial_direction, next_direction|
      context "when direction is #{initial_direction}" do
        let(:initial_direction) { initial_direction }
        let(:next_direction) { next_direction }

        subject { described_class.new(initial_direction) }

        it "next direction is #{next_direction}" do
          subject.turn_anti_clockwise
          expect(subject.facing_direction).to eq(next_direction)
        end

      end

    end

    DIRECTIONS.zip(DIRECTIONS.rotate(-1)).each do |initial_direction, next_direction|
      it_behaves_like 'turn_anti_clockwise', initial_direction, next_direction
    end

  end

end
