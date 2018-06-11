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
    @categories << Category.new(title, percent)
    sort_categories_by_title
  end

  def generate
    @categories.each do |c|
      last_event_start_time = (@calendar.events.last && @calendar.events.last.stop) || Clock.new(0, 0)
      hours = (24*60*c.percent/60).to_i
      minutes = (24*60*c.percent%60).to_i * 0.01
      added_time = hours + minutes
      end_time = last_event_start_time + added_time
      puts "calculation: #{c.percent * minutes_in_day / 60}"
      puts "last_start -> end_time: #{last_event_start_time} -> #{end_time}"
      until @calendar.add_event(last_event_start_time.to_f, end_time.to_f, c.title)
        last_event_start_time += 0.01
      end
    end
  end

  def list_events
    @calendar.list_events
  end

  def list_categories
    @categories.each do |c|
      puts c
    end
  end

  private

  def sort_categories_by_title
    @categories.sort_by!(&:title)
  end

  def can_add_percent?(percent)
    @categories.sum(&:percent) < 100
  end

  def minutes_in_day
    24 * 60
  end
end

g = Generator.new
g.add_category('Coding', 30)
g.add_category('SAT', 30)
g.add_category('Fitness', 30)
g.add_category('Reading', 10)
g.list_categories
g.generate
g.list_events
