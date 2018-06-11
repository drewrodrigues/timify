require_relative 'time_range'

class Event < TimeRange
  attr_reader :category

  def initialize(start, stop, category)
    super(start, stop)
    @category = category
  end

  def to_s
    "#{@category}: #{super}"
  end

  def intersects?(other_event)
    [other_event.start, other_event.stop].each do |time|
      return true if (time < stop && time > start) || self == other_event
    end
    false
  end
end
