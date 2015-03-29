class Summary

  extend Forwardable

  def_delegator :@summary, :[]
  
  def initialize(blocks, disciplines)
    @blocks = blocks
    @disciplines = disciplines
    create
  end

   def to_json
    lengths = {}
    @summary.each_pair do |key, value|
      lengths[key] = value.map { |duration| duration.length/3600.0 }
    end
    lengths.to_json
  end

  private

  def create
    @summary = {}
    allocate
    aggregate
    map
    @summary
  end

  def allocate
    @summary['Total'] = new_null_duration_array
    @disciplines.each do |discipline|
      @summary[discipline.id] = new_null_duration_array
    end
  end

  def new_null_duration_array
    Array.new(Block::MEMORY_LENGTH, TimeDuration::Null.new)
  end

  def aggregate
    @blocks.each do |block|
      days_ago = Time.zone.now.to_date - block.start.to_date
      @summary[block.discipline_id][days_ago] += block.duration
      @summary['Total'][days_ago] += block.duration
    end
  end

  def map
    @disciplines.each do |discipline|
      @summary[discipline.title] = @summary.delete(discipline.id)
    end
  end

end


