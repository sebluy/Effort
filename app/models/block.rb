require 'time_range'

class Block < ActiveRecord::Base

  belongs_to :discipline

  def duration
    TimeDuration.new(start, finish)
  end

  def finish_new
    update(finish: Time.zone.now)
  end

  def self.start_new
    self.create(start: Time.zone.now)
  end

  def self.pending
    self.where(finish: nil)
  end

end
