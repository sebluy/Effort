class TimeDuration

  attr_reader :length

  def initialize(seconds)
    @length = seconds
  end

  def to_s
    if @length < 1.day
      Time.at(@length).gmtime.strftime('%H:%M:%S')
    else
      '> 1 day'
    end
  end

  def +(duration)
    TimeDuration.new(@length + duration.length)
  end

end


