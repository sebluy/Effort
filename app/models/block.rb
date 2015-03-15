class Block < ActiveRecord::Base

  belongs_to :discipline

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
    Block.where(finish: nil)
  end

  def Block.clean
    start = Block.arel_table[:start]
    Block.where(start.lt(12.days.ago.to_date)).delete_all   
  end

end
