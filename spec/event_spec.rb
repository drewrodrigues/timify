require_relative '../lib/event'

RSpec.describe Event do
  let(:event) { Event.new(TimeRange.new(0.0, 0.3), 'Category') }

  describe 'attributes' do
    it 'has a TimeRange' do
      expect(event.time_range.class).to eq(TimeRange)
    end

    it 'has a category' do
      expect(event.respond_to?(:category)).to be(true)
    end
  end

  describe '#start' do
    it 'returns the start time' do
      expect(event.start).to eq(0.0)
    end
  end

  describe '#stop' do
    it 'returns the stop time' do
      expect(event.stop).to eq(0.3)
    end
  end

  describe '#category' do
    it 'returns the category' do
      expect(event.category).to eq('Category')
    end
  end
end
