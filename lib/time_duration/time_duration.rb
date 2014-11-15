module TimeDuration

  def to_s
    if length < 1.day
      Time.at(length).gmtime.strftime('%H:%M:%S')
    else
      '>= 1 day'
    end
  end

  def +(duration)
    Aggregate.new(self, duration)
  end

  class Finished

    #include TimeDuration

    attr_reader :length

    def initialize(seconds)
      @length = seconds
    end

  end

  class Unfinished

    #include TimeDuration
    
    def initialize(start)
      @start = start
    end

    def length
      Time.zone.now - @start
    end

  end

  class Null

    #include TimeDuration
    
    def length
      0
    end

  end

  class Aggregate
    
  #  include TimeDuration
    
    def initialize(*durations)
      @durations = *durations
    end

    def length
      @durations.inject(0) { |sum, duration| sum + duration.length }
    end

  end

end
