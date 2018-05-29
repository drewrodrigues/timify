require_relative 'lib/calendar'
require_relative 'lib/category'
require_relative 'lib/event'
require_relative 'lib/time_range'

c = Calendar.new
c.add_event(TimeRange.new(0.0, 0.3), 'Fitness')
c.list_events
