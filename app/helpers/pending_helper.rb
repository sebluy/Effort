module PendingHelper

  attr_reader :pending

  def pending?
    !pending.nil?
  end

  def pending_discipline?(discipline)
    return false unless pending? 
    pending.discipline_id == discipline.id
  end

end
