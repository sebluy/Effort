class Discipline < ActiveRecord::Base

  RANGE_OFFSETS = {
    today: { start: 0, finish: 0},
    yesterday: { start: 1.day, finish: 1.day},
    week: { start: 1.week, finish: 0}
  }

  RANGES = RANGE_OFFSETS.keys

  has_many :blocks, dependent: :destroy

  def start_new_block
    blocks.start_new
  end
  
  def time_spent(period)
    blocks_in_range(period).inject(TimeDuration::Null.new) do |sum, block| 
      sum + block.duration
    end 
  end
  
  def self.time_spent(period)
    self.all.inject(TimeDuration::Null.new) do |sum, discipline|
      sum + discipline.time_spent(period)
    end
  end

  private

    def blocks_in_range(period)
      return blocks if period == :all
      blocks.where(start: range(period))
    end

    def range(period)
      today = Time.zone.today
      start = today - RANGE_OFFSETS[period][:start]
      finish = today - RANGE_OFFSETS[period][:finish]
      (start.beginning_of_day)..(finish.end_of_day)
    end

end
