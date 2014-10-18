class Block < ActiveRecord::Base

  belongs_to :discipline

  def time_spent
    if finish.nil?
      Time.zone.now - start
    else
      finish - start
    end
  end
      
  
end
