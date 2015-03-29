class Block < ActiveRecord::Base

  belongs_to :discipline

  MEMORY_LENGTH = 13

  def duration
    TimeDuration.new(start, finish)
  end

  def finish_new
    update(finish: Time.zone.now)
  end

  def Block.start_new
    Block.create(start: Time.zone.now)
  end

  def Block.pending
    Block.find_by(finish: nil)
  end

  def Block.clean
    start = Block.arel_table[:start]
    expiration_time = (MEMORY_LENGTH - 1).days.ago.at_beginning_of_day
    Block.where(start.lt(expiration_time)).delete_all   
  end

end
