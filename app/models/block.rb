class Block < ActiveRecord::Base

  belongs_to :discipline

  MEMORY_LENGTH = 12.days

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
    Block.where(start.lt(MEMORY_LENGTH.ago.to_date)).delete_all   
  end

end
