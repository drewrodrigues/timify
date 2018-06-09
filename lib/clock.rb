class Clock
  include Comparable

  HOURS = (0..23).to_a
  TIMES = []
  HOURS.each do |hour|
    60.times do |i|
      TIMES << (hour + 0.01 * i).round(2)
    end
  end

  attr_reader :minutes, :hours

  def initialize(hours, minutes)
    self.hours = hours
    self.minutes = minutes
  end

  def to_s
    "#{@hours}:#{padded_minutes}"
  end

  def hours=(hours)
    raise ArgumentError if hours.negative?
    @hours = if hours > 23
               hours % 24
             else
               hours
             end
  end

  def minutes=(minutes)
    raise ArgumentError if minutes.negative?
    @minutes = if minutes >= 60
                 @hours += 1
                 minutes % 60
               else
                 minutes
               end
  end

  def <=>(other)
    raise ArgumentError, 'Must pass a Clock' unless other.is_a?(Clock)
    (@hours + @minutes * 0.01) <=> (other.hours + other.minutes * 0.01)
  end

  def +(other)
    if other.is_a?(Integer)
      @hours += other
    elsif other.is_a?(Float)
      @hours += other.to_i
      @minutes += (other % 1 * 100).to_i
    else
      non_number_error
    end
  end

  def -(other)
    if other.is_a?(Integer)
      @hours -= other
    elsif other.is_a?(Float)
      @minutes -= (other % 1 * 100).to_i
    else
      non_number_error
    end
  end

  private

  def non_number_error
    raise ArgumentError, 'Must give a number'
  end

  def padded_minutes
    @minutes < 10 ? "0#{@minutes}" : @minutes
  end
end
