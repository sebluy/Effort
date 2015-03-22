module BlocksHelper

  def finish_button(block)
    link_to 'Finish',
        finish_discipline_block_path(block.discipline, block),
        method: :post, class: 'btn btn-sm btn-danger'
  end

end
