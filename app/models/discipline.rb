class Discipline < ActiveRecord::Base

  has_many :blocks

  def time_spent_all
    blocks.inject(0) { |sum, block| sum + block.time_spent }
  end

  def time_spent_today
    todays_blocks.inject(0) do |sum, block|
      sum + block.time_spent
    end
  end

  def todays_blocks
    blocks.where(start: today_range)
  end

  private

    def today_range
      (Time.now.midnight)..(Time.now.midnight + 1.day)
    end
  
end
