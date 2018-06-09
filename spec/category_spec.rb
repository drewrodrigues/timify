require_relative '../lib/category'

RSpec.describe Category do
  let(:category) { Category.new('Fitness', 25) }

  describe 'attributes' do
    it 'has a title' do
      expect(category.respond_to?(:title)).to be true
    end

    it 'has a percent' do
      expect(category.respond_to?(:percent)).to be true
    end
  end

  describe 'validations' do
    context '0% or <' do
      it 'raises an error' do
        expect {
          Category.new('Coding', -50)
        }.to raise_error(ArgumentError)
      end
    end

    context '> 100%' do
      it 'raises an error' do
        expect {
          Category.new('Reading', 101)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
