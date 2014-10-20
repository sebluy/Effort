class DurationConverter

  UNITS = [:seconds, :minutes, :hours, :days, :weeks, :months, :years]
  
  CONVERSIONS = [60.0, 60.0, 24.0, 7.0, 4.35, 12]

  attr_accessor :quantity
  attr_accessor :unit

  def initialize(quantity=0, unit=:seconds)
    @quantity = quantity
    @unit = unit
  end
  
  def convert!(new_unit)
    start = UNITS.index(@unit)
    finish = UNITS.index(new_unit)
    steps = finish - start
    if steps > 0
      start.upto(finish - 1) do |index|
        @quantity /= CONVERSIONS[index] 
      end
    elsif steps < 0
      (start - 1).downto(finish) do |index|
        @quantity *= CONVERSIONS[index]
      end
    end
    @unit = new_unit 
    self
  end

  def auto_unit
    while true
      current = UNITS.index(@unit)

      next_unit = UNITS[current + 1]
      previous = UNITS[current - 1]

      if @unit != :years && @quantity > CONVERSIONS[current]
        convert!(UNITS[current + 1])
      elsif @unit != :seconds && @quantity < 1/CONVERSIONS[current - 1]
        convert!(UNITS[current - 1])
      else
        return self
      end
    end
  end
  
  def to_s
    sprintf "%.1f %s", quantity, unit
  end

end



