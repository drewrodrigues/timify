require_relative '../lib/event'

RSpec.describe Event do
  let(:event) { Event.new(0.0, 0.3, 'Category') }

  describe '#category' do
    it 'returns the category' do
      expect(event.category).to eq('Category')
    end
  end
end
