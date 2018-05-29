class Calendar
  attr_reader :events

  def initialize
    @events = []
  end

  def add_event(time_range, category)
    event = Event.new(time_range, category)
    return false unless saveable?(event)
    events << Event.new(time_range, category)
  end

  def remove_event(start)
    before = @events.count
    events.delete_if { |e| e.start == start }
    before != @events.count
  end

  def list_events
    events.sort_by!(&:start)
    events.each do |e|
      puts e
    end
  end

  private

  def saveable?(event)
    events.each do |e|
      return false unless non_intersecting_time?(event, e)
    end
    true
  end

  def non_intersecting_time?(event, other_event)
    return true unless start_time_intersects_event?(event, other_event) || end_time_intersects_event?(event, other_event) || same_time(event, other_event)
  end

  def start_time_intersects_event?(event, other_event)
    event.start < other_event.stop && event.start > other_event.start
  end

  def end_time_intersects_event?(event, other_event)
    event.stop < other_event.stop && event.stop > other_event.start
  end

  def same_time(event, other_event)
    event.start == other_event.start && event.stop == other_event.stop
  end
end