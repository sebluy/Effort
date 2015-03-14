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

  def clean
    day = 6.days.ago.to_date
    start_field = Block.arel_table[:start]
    blocks.where(start_field.lt(day)).each(&:destroy)
  end
  
  def old
    day = (Time.zone.today - 6.days).to_date
    start_field = Block.arel_table[:start]
    blocks.where(start_field.lt(day)).
        inject(TimeDuration::Null.new) do |sum, block|
      sum + block.duration
    end
  end

  def self.old
    self.all.inject(TimeDuration::Null.new) do |sum, discipline|
      sum + discipline.old
    end
  end

  def self.clean
    self.all.each do |discipline|
      discipline.clean
    end
  end

end
