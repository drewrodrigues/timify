class Category
  attr_reader :title, :percent

  def initialize(title, percent)
    @title = title
    self.percent = percent
  end

  def to_s
    "#{@title}: #{@percent}%"
  end

  def percent=(percent)
    raise ArgumentError, 'Percent must be 1-100' unless percent.between?(1, 100)
    @percent = percent * 0.01
  end
end
