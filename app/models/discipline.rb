require 'duration_string'

class Discipline < ActiveRecord::Base

  has_many :blocks

  def start_new_block
    blocks.start_new
  end

  def time_spent_all
    blocks.inject(0) { |sum, block| sum + block.time_spent }
  end

  def time_spent_today
    todays_blocks.inject(0) do |sum, block|
      sum + block.time_spent
    end
  end
  
  def time_spent_all_string
    DurationString.convert(time_spent_all)
  end

  def time_spent_today_string
    Duration.convert(time_spent_today)
  end

  private

    def todays_blocks
      blocks.where(start: today_range)
    end

    def today_range
      (Time.now.beginning_of_day)..(Time.now.end_of_day)
    end
  
end
