class TimeRange

  def initialize(start, finish)
    @finish = finish || Unfinished.new
    @start = start || finish
  end

  def length
    @finish - @start
  end

  def to_s
    Time.at(length).gmtime.strftime('%H:%M:%S')
  end

  class Unfinished

    def -(_)
      0
    end
  
  end

end


