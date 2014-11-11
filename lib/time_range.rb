class TimeRange

  def initialize(start, finish)
    @start, @finish = start, finish
    @duration = duration
  end

  def length
    @duration.length
  end

  def to_s
    @duration.to_s
  end

  def duration
    if @start && @finish
      TimeDuration.new(start - finish)
    elsif @start
      UnfinishedTimeDuration.new(start)
    else
      NullTimeDuration.new
    end
  end

end


