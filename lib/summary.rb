class Summary

  def self.alternate_summary
    summary = {}

    blocks = Block.all
    disciplines = Discipline.all

    total = Array.new(Block::MEMORY_LENGTH/1.day + 1,
                        TimeDuration::Null.new)

    disciplines.each do |discipline|
      summary[discipline.id] = Array.new(Block::MEMORY_LENGTH/1.day + 1,
          TimeDuration::Null.new)
    end

    blocks.each do |block|
      days_ago = Date.today - block.start.to_date
      summary[block.discipline_id][days_ago] += block.duration
      summary['Total'][days_ago] += block.duration
    end
    
    summary
  end

end


