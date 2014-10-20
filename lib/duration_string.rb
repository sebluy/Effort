module DurationString

  UNITS = [ :years, :months, :weeks, :days, :hours, :minutes, :seconds ]

  def self.convert(seconds)
    Converter.new(seconds).autoscale.to_s
  end

  class Converter

    def initialize(seconds)
      @seconds = seconds.to_i
      @quantities = {}
    end

    def autoscale

      UNITS.each do |unit|
        conversion = 1.send(unit).to_i
        quantity_in_unit = @seconds/conversion
        @quantities[unit] = quantity_in_unit
        @seconds -= quantity_in_unit*conversion
      end

      self
    end

    def unit_string(unit)
      unit_name = @quantities[unit] == 1 ? unit.to_s.chop : unit
      "#{@quantities[unit]} #{unit_name}"
    end

    def to_s(num_units=2)

      string = ''
      units_remaining = num_units

      UNITS.each do |unit|
        if @quantities[unit] != 0
          string << unit_string(unit) + ' '
          units_remaining -= 1
        end
        break if units_remaining == 0
      end
      
      string.chop
    end
    
  end

end



