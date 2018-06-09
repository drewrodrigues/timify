require_relative '../lib/clock'

RSpec.describe Clock do
  let(:clock) { Clock.new(5, 30) }
  describe 'attributes' do
    it 'has hours' do
      expect(clock.respond_to?(:hours)).to be true
    end

    it 'has minutes' do
      expect(clock.respond_to?(:minutes)).to be true
    end
  end

  describe 'validations' do
    context 'when hours = 24' do
      it 'wraps to 0' do
        clock.hours = 24
        expect(clock.hours).to eq(0)
      end
    end

    context 'when hours = 30' do
      it 'wraps to 6' do
        clock.hours = 30
        expect(clock.hours).to eq(6)
      end
    end

    context 'when hours is negative' do
      it 'raises an error' do
        expect {
          clock.hours = -1
        }.to raise_error(ArgumentError)
      end
    end

    context 'when minutes = 60' do
      it 'adds 1 to hours' do
        expect {
          clock.minutes = 60
        }.to change(clock, :hours).by(1)
      end

      it 'wraps to 0 minutes' do
        clock.minutes = 60
        expect(clock.minutes).to eq(0)
      end
    end

    context 'when minutes is negative' do
      it 'raises an error' do
        expect {
          clock.minutes = -1
        }.to raise_error(ArgumentError)
      end
    end

    context 'when minutes is 71' do
      it 'adds 1 to hours' do
        expect {
          clock.minutes = 71
        }.to change(clock, :hours).by(1)
      end

      it 'wraps to 11 minutes' do
        clock.minutes = 71
        expect(clock.minutes).to eq(11)
      end
    end
  end

  describe '#<' do
  end

  describe '#>' do
  end
end
