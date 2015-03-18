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
    summary = {}
    total = Array.new(Block::MEMORY_LENGTH/1.day + 1,
                        TimeDuration::Null.new)

    Discipline.find_each do |discipline|
      summary[discipline.title] = []
      0.upto(Block::MEMORY_LENGTH/1.day) do |n|
        time = discipline.daily_time_spent(n.days.ago)
        summary[discipline.title] << time
        total[n] += time
      end
    end

    summary['Total'] = total
    summary
  end

end
