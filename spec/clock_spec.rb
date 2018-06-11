require_relative '../lib/clock'
require 'byebug'

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
    context 'when other greater than' do
      it 'returns true' do
        other = clock + 1
        expect(clock < other).to be true
      end
    end

    context 'when other less than' do
      it 'returns false' do
        other = clock - 1
        expect(clock < other).to be false
      end
    end
  end

  describe '#>' do
    context 'when other is greater than' do
      it 'returns false' do
        other = clock + 1
        expect(clock > other).to be false
      end
    end

    context 'when other is less than' do
      it 'returns true' do
        other = clock - 1
        expect(clock > other).to be true
      end
    end
  end

  describe '#==' do
    context 'when equal' do
      it 'returns true' do
        other = clock.dup
        expect(clock == other).to be true
      end
    end

    context 'when not equal' do
      it 'returns false' do
        other = clock + 0.3
        expect(clock == other).to be false
      end
    end
  end

  describe '#+' do
    it 'doesn\'t change the original object' do
      # TODO: implement once figuring out the nil error that's occuring
      c = Clock.new(6, 30)
      expect {
        c + 0.10
      }.to_not change(c, :minutes)
    end

    context 'when minutes sum is 60' do
      it 'wraps to 0' do
        # FIXME: clock = clock + 0.3 not working correctly
        # getting a undefined method '+' for nil error
        other = clock + 0.30
        expect(other.minutes).to eq(0)
      end

      it 'adds 1 to hours' do
        # FIXME: still getting undefined method '+' for nil error like above
        c = Clock.new(6, 30)
        expect {
          c += 0.30
        }.to change { c.hours }.by(1)
      end
    end
  end

  describe '#-' do
    it 'doesn\'t change the original object' do
      c = Clock.new(6, 30)

      expect {
        c - 1
      }.to_not change { c.hours }
    end

    context 'when minutes difference is -1' do
      it 'wraps to 59' do
        other = clock - 0.31
        expect(other.minutes).to eq(59)
      end

      it 'decrements hours by 1' do
        other = clock
        expect {
          other -= 0.31
        }.to change { other.hours }.by(-1)
      end
    end
  end
end
