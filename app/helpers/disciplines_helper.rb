module DisciplinesHelper

  def start_button(discipline)
    link_to 'Start', start_discipline_block_path(discipline),
      method: :post, class: 'btn btn-sm btn-success'
  end

  def summary_to_json
    lengths = {}
    @summary.each_pair do |key, value|
      lengths[key] = value.map { |duration| duration.length/3600.0 }
    end
    lengths.to_json
  end

end
