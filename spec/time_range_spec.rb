require_relative '../lib/time_range'
require 'byebug'

RSpec.describe TimeRange do
  let(:time_range) { TimeRange.new(0.30, 3.30) }

  describe 'attributes' do
    it 'has a start time' do
      expect(time_range.start.class).to eq(Clock)
    end

    it 'has a stop time' do
      expect(time_range.stop.class).to eq(Clock)
    end
  end

  describe 'validations' do
    context 'start time < stop time' do
    end

    context 'start time > stop time' do
      it 'raises an error' do
        expect {
          time_range.start = 3.31
        }.to raise_error(ArgumentError)
      end
    end

    context 'stop time < start time' do
      it 'raises an error' do
        expect {
          time_range.stop = 0.29
        }.to raise_error(ArgumentError)
      end
    end
  end
end
