require_relative 'event'
require 'byebug'

# Calendar is a manager for events which provides validations for whether
# it can be added or not based upon interesecting event times of already
# existing events.
# ------------------------------------------------------------------------------
# >> c = Calendar.new
#
# add_event(Float/Integer, Float/Integer, String)
# - Adds an event based upon start and stop time and a category name.
# >> c.add_event(0.0, 0.30, 'Category Name')
#
# remove_event(String)
# - Removes an event based upon the starting time.
# >> c.remove_event('0:00')
class Calendar
  attr_reader :events

  def initialize
    @events = []
  end

  def add_event(start, stop, category)
    event = Event.new(start, stop, category)
    return false unless saveable?(event)
    events << event
    events.sort_by!(&:start)
  end

  def remove_event(start)
    before = @events.count
    events.delete_if { |e| e.start.to_s == start }
    before != @events.count
  end

  def list_events
    events.each do |e|
      puts e
    end
  end

  private

  def saveable?(event)
    @events.each do |e|
      return false if event.intersects?(e)
    end
    true
  end
end
