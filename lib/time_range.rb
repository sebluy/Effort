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
      TimeDuration::Finished.new(@finish - @start)
    elsif @start
      TimeDuration::Unfinished.new(@start)
    else
      TimeDuration::Null.new
    end
  end

end


