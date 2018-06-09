require_relative 'event'

# Calendar is a manager for events which provides validations for whether
# it can be added or not based upon interesecting event times of already
# existing events.
class Calendar
  attr_reader :events

  def initialize
    @events = []
  end

  def add_event(start, stop, category)
    event = Event.new(start, stop, category)
    # return false unless saveable?(event)
    events << event
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

  def saveable?(event); end
end
