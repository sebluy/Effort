module DisciplinesHelper

  def start_button(discipline)
    link_to 'Start', start_discipline_block_path(discipline),
      method: :post, class: 'btn btn-sm btn-success'
  end

end
