require 'byebug'

# Clock is a simple implementation of holding hours (0-23) and minutes (0-59).
# ------------------------------------------------------------------------------
# Clock.new(integer, integer)
# - Creates a clock object with hours and minutes.
# >> c = Clock.new(5, 30)
#
# >> c = Clock.new(14, 30)
#
# to_s
# - Prints hours and minutes with padding on minutes if necessary.
# >> puts c
# => "14:30"
#
# +(Float/Integer)
# - Adds the integer portion to hours and the decimal portion to minutes.
# >> c + 1
# => "15:30"
# >> c + 0.30
# => "16:00"
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

  def to_f
    @hours.to_i + @minutes * 0.01
  end

  def hours=(hours)
    @hours = if hours > 23 || hours < 0
               hours % 24
             else
               hours
             end
  end

  def minutes=(minutes)
    @minutes = if minutes >= 60
                 @hours += 1
                 minutes % 60
               elsif minutes < 0
                 @hours += minutes / 60
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
    self_dup = dup
    if other.is_a?(Integer)
      self_dup.hours += other
    elsif other.is_a?(Float)
      self_dup.hours += other.to_i
      self_dup.minutes += (other % 1 * 100).to_i
    else
      non_number_error
    end
    self_dup
  end

  def -(other)
    self_dup = dup
    if other.is_a?(Integer)
      self_dup.hours -= other
    elsif other.is_a?(Float)
      self_dup.minutes -= (other % 1 * 100).to_i
    else
      non_number_error
    end
    self_dup
  end

  private

  def non_number_error
    raise ArgumentError, 'Must give a number'
  end

  def padded_minutes
    @minutes < 10 ? "0#{@minutes}" : @minutes
  end
end
