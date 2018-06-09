require_relative '../lib/generator'

RSpec.describe Generator do
  let(:generator) { Generator.new }

  describe 'attributes' do
    it 'has a Calendar' do
      expect(generator.calendar.class).to eq(Calendar)
    end

    it 'has categories' do
      expect(generator.respond_to?(:categories)).to be true
    end
  end

  describe '#add_category' do
    context 'categories sum < 100%' do
      it 'returns true' do
        expect(generator.add_category('Fitness', 50)).to be_truthy
      end

      it 'increments categories' do
        expect {
          generator.add_category('Fitness', 100)
        }.to change(generator.categories, :count).by(1)
      end
    end

    context 'categories sum >= 100%' do
      it 'returns false' do
        generator.add_category('Fitness', 100)

        expect(generator.add_category('Fitness', 50)).to be false
      end
    end
  end

  describe '#generate' do
    it 'does something' do
      generator.add_category('Fitness', 100)

      generator.generate
    end
  end
end
