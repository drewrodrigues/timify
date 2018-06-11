require_relative 'clock'

# TimeRange contains a start and stop time which are both Clocks.
# It ensures start time is before start time.
#
# TimeRange.new(0, 0.30)
# This will represent the time 12:00am -> 12:30am
#
# puts TimeRange.new(0, 0.30)
# => 0:00 -> 0:30
class TimeRange
  attr_reader :start, :stop

  def initialize(start, stop)
    self.start = start
    self.stop = stop
  end

  def to_s
    "#{start} -> #{stop}"
  end

  def start=(start)
    temp_start = Clock.new(start.to_i, decimal_of(start))
    ensure_valid_start(temp_start)
    @start = temp_start
  end

  def stop=(stop)
    temp_stop = Clock.new(stop.to_i, decimal_of(stop))
    ensure_valid_stop(temp_stop)
    @stop = temp_stop
  end

  def ==(other)
    raise ArgumentError, 'Must pass a TimeRange' unless other.is_a?(TimeRange)
    @start == other.start && @stop == other.stop
  end

  private

  def ensure_valid_start(start)
    return true unless @stop
    raise ArgumentError, 'Start time must be < stop time' if start > @stop 
  end

  def ensure_valid_stop(stop)
    return true unless @start
    raise ArgumentError, 'Stop time must be > start time' if @start > stop && stop != Clock.new(0, 0)
  end

  def decimal_of(number)
    (number % 1 * 100).to_i
  end
end
