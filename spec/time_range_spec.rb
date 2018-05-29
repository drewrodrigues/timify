require_relative '../lib/time_range'

RSpec.describe TimeRange do
  let(:time_range) { TimeRange.new(0.0, 0.3) }

  describe 'attributes' do
    it 'has a start time' do
      expect(time_range.respond_to?(:start)).to be true
    end

    it 'has a stop time' do
      expect(time_range.respond_to?(:stop)).to be true
    end

    it 'returns the correct start time' do
      expect(time_range.start).to eq(0.0)
    end

    it 'returns the correct stop time' do
      expect(time_range.stop).to eq(0.3)
    end
  end

  describe 'validations' do
    context 'start time > stop time' do
      it 'raises an error' do
        expect {
          time_range.start = time_range.stop + 1
        }.to raise_error(ArgumentError)
      end
    end

    context 'stop time < start time' do
      it 'raises an error' do
        expect {
          time_range.stop = time_range.start - 1
        }.to raise_error(ArgumentError)
      end
    end

    context 'invalid time' do
      it 'raises an error' do
        expect {
          time_range.start = 25
        }.to raise_error(ArgumentError)
      end
    end
  end
end
