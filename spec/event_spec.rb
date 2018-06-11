require_relative '../lib/event'

RSpec.describe Event do
  let(:event) { Event.new(1.3, 2.3, 'Category') }

  describe '#intersects?' do
    context 'when event start intersects other event' do
      it 'returns true' do
        intersecting_event = Event.new(2, 3, 'Fitness')
        expect(intersecting_event.intersects?(event)).to be true
      end
    end

    context 'when event stop intersects other event' do
      it 'returns true' do
        intersecting_event = Event.new(0, 2, 'Anything')
        expect(intersecting_event.intersects?(event)).to be true
      end
    end

    context 'when event has the same start and stop time' do
      it 'returns true' do
        intersecting_event = Event.new(1.3, 2.3, 'Something Else')
        expect(intersecting_event.intersects?(event)).to be true
      end
    end

    context 'when event doesn\'t insersect other event' do
      it 'returns false' do
        non_intersecting_event = Event.new(0.3, 0.45, 'Something')
        expect(non_intersecting_event.intersects?(event)).to be false
      end
    end
  end
end
