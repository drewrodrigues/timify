class TimeRange
  HOURS = (0..23).to_a
  TIMES = []
  HOURS.each do |hour|
    4.times do |i|
      TIMES << (hour + 0.15 * i).round(2)
    end
  end

  attr_reader :start, :stop

  def initialize(start, stop)
    @start = start
    @stop = stop
    validate
  end

  def start=(start)
    @start = start
    validate
  end

  def stop=(stop)
    @stop = stop
    validate
  end

  def to_s
    "#{start} - #{stop}"
  end

  def validate
    raise ArgumentError, 'Not valid time' unless TIMES.include?(start) && TIMES.include?(stop)
    raise ArgumentError, 'Start time must be before start time' unless @start < @stop
  end
end
