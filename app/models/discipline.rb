require 'duration_string'

class Discipline < ActiveRecord::Base

  has_many :blocks

  def start_new_block
    blocks.start_new
  end
  
  def time_spent(period=:all, as_string=true)
    time = blocks_in_range(period).inject(0) do |sum, block| 
      sum + block.time_spent
    end 
    if as_string
      string(time)
    else
      time
    end
  end

  private

    def string(time)
      DurationString.convert(time)
    end

    def blocks_in_range(period)
      return blocks if period == :all
      blocks.where(start: range(period))
    end

    RANGE_OFFSETS = { 
      today: { start: 0, finish: 0},
      yesterday: { start: 1.day, finish: 1.day},
      week: { start: 1.week, finish: 0},
      month: { start: 1.month, finish: 0},
      year: { start: 1.year, finish: 0}
    }

    def range(period)
      today = Date.today
      start = today - RANGE_OFFSETS[period][:start]
      finish = today - RANGE_OFFSETS[period][:finish]
      (start.beginning_of_day)..(finish.end_of_day)
    end

end
