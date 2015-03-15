module TimeDuration

  include Comparable

  def self.new(start, finish)
    if start && finish
      TimeDuration::Finished.new(finish - start)
    elsif start
      TimeDuration::Unfinished.new(start)
    else
      TimeDuration::Null.new
    end
  end

  def to_s
    if length < 1.day
      Time.at(length).gmtime.strftime('%H:%M:%S')
    else
      sprintf('%.1f days', length.to_f/1.day)
    end
  end

  def to_json
    length
  end

  def +(duration)
    Aggregate.new(self, duration)
  end

  def <=>(duration)
    length <=> duration.length
  end

  def ==(another)
    if another.is_a? TimeDuration
      length == another.length
    else
      length == another
    end
  end

  class Finished
    
    include TimeDuration

    attr_reader :length

    def initialize(seconds)
      @length = seconds
    end

  end

  class Unfinished

    include TimeDuration

    def initialize(start)
      @start = start
    end

    def length
      Time.zone.now - @start
    end

  end

  class Null

    include TimeDuration

    def length
      0
    end

  end

  class Aggregate
    
    include TimeDuration

    def initialize(*durations)
      @durations = *durations
    end

    def length
      @durations.inject(0) { |sum, duration| sum + duration.length }
    end

  end

end
