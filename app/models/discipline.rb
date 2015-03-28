class Discipline < ActiveRecord::Base

  has_many :blocks, dependent: :destroy

  def start_new_block
    blocks.start_new
  end

  def daily_time_spent(date)
    range = (date.beginning_of_day)..(date.end_of_day)
    daily_blocks = blocks.where(start: range)
    daily_blocks.inject(TimeDuration::Null.new) do |sum, block|
      sum + block.duration 
    end
  end
  
  def self.daily_time_spent(date)
    self.all.inject(TimeDuration::Null.new) do |sum, discipline|
      sum + discipline.daily_time_spent(date)
    end
  end

  def self.summary
    Summary.new(Block.all, Discipline.all)
  end

end
