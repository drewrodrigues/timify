class Event
  attr_reader :category, :time_range

  def initialize(start, stop, category)
    @time_range = TimeRange.new(start, stop)
    @category = category
  end

  def to_s
    "#{@category}: #{@time_range}"
  end

  def start
    @time_range.start
  end

  def stop
    @time_range.stop
  end
end
