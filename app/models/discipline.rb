require 'duration_string'

class Discipline < ActiveRecord::Base
  
  RANGES = [:today, :yesterday, :week, :month, :year, :all]

  has_many :blocks, dependent: :destroy

  def start_new_block
    blocks.start_new
  end
  
  def time_spent(period=:all, as_string=true)
    time = blocks_in_range(period).inject(0) do |sum, block| 
      sum + block.time_spent
    end 
    if as_string
      Discipline.string(time)
    else
      time
    end
  end
  
  def self.time_spent(period=:all, as_string=true)
    time = self.all.inject(0) do |sum, discipline|
      sum + discipline.time_spent(period, false)
    end
    if as_string
      self.string(time)
    else
      time
    end
  end

  private

    def self.string(time)
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
      today = Time.zone.today
      start = today - RANGE_OFFSETS[period][:start]
      finish = today - RANGE_OFFSETS[period][:finish]
      (start.beginning_of_day)..(finish.end_of_day)
    end

end
