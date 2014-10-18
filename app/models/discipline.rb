class Discipline < ActiveRecord::Base

  has_many :blocks

  def total_time_spent
    blocks.inject(0) { |sum, block| sum + block.time_spent }
  end
  
end
