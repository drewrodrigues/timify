require_relative '../lib/calendar'

RSpec.describe Calendar do
  let(:calendar) { Calendar.new }

  describe 'attributes' do
    it 'has events' do
      expect(calendar.respond_to?(:events)).to be true
    end
  end

  describe '#add_event' do
    context 'valid event' do
      it 'increments events' do
        expect {
          calendar.add_event(TimeRange.new(0.0, 0.3), 'Fitness')
        }.to change(calendar.events, :count).by(1)
      end
    end

    context 'invalid event' do
      it 'returns false' do
        calendar.add_event(TimeRange.new(0.0, 0.3), 'Study')

        expect(calendar.add_event(TimeRange.new(0.0, 0.3), 'Reading')).to be_falsey
      end
    end
  end

  describe '#remove_event' do
    context 'valid event' do
      it 'returns true' do
        expect(calendar.add_event(TimeRange.new(0.0, 0.3), 'Study')).to be_truthy
      end

      it 'decrements events' do
        calendar.add_event(TimeRange.new(0.0, 0.3), 'Study')

        expect {
          calendar.remove_event(0.0)
        }.to change(calendar.events, :count).by(-1)
      end
    end

    context 'invalid event' do
      it 'returns false' do
        calendar.add_event(TimeRange.new(0.0, 0.3), 'Study')

        expect(calendar.remove_event(0.3)).to be_falsey
      end
    end
  end
end
