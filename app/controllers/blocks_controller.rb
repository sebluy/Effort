class BlocksController < ApplicationController
  
  def start
    discipline = params[:discipline_id]
    Discipline.find(discipline).start_new_block
    redirect_to disciplines_path
  end

  def finish
    Block.find(params[:id]).finish_new
    redirect_to disciplines_path
  end

  def edit
    @block = Block.find(params[:id])
    @discipline = @block.discipline
  end

  def update
    Block.find(params[:id]).update(block_params)
    redirect_to discipline_path(params[:discipline_id]) 
  end
  
  def destroy
    Block.find(params[:id]).destroy
    redirect_to discipline_path(params[:discipline_id])
  end

  private
    
    def block_params
      params.require(:block).permit(:start, :finish)
    end

end
