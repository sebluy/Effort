class Block < ActiveRecord::Base

  belongs_to :discipline

  def time_spent
    if finish.nil?
      Time.now - start
    else
      finish - start
    end
  end

  def finish_new
    update(finish: Time.now)
  end

  def self.start_new
    self.create(start: Time.now)
  end

end
