require_relative 'calendar'
require_relative 'category'
require_relative 'time_range'

class Generator
  attr_reader :calendar, :categories

  def initialize
    @calendar = Calendar.new
    @categories = []
  end

  def add_category(title, percent)
    return false unless can_add_percent?(percent)
    add_category_(title, percent)
    sort_categories_by_title
  end

  def generate
    # get each categories percentage
    @categories.each do |c|
    end
  end

  def list_events
    @calendar.list_events
  end

  private

    def sort_categories_by_title
      @categories.sort_by!(&:title)
    end

    def add_category_(title, percent)
      @categories << Category.new(title, percent)
    end

    def can_add_percent?(percent)
      @categories.sum { |c| c.percent } < 100
    end
end

g = Generator.new
g.add_category('Coding', 30)
g.add_category('SAT', 30)
g.add_category('Fitness', 30)
g.add_category('Reading', 10)
g.generate
g.list_events
