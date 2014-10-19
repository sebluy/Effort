class BlocksController < ApplicationController
  
  def start
    discipline = params[:discipline_id]
    Discipline.find(discipline).start_new_block
    redirect_to discipline_path(discipline)
  end

  def finish
    Block.find(params[:id]).finish_new
    redirect_to discipline_path(params[:discipline_id])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    @block = Block.find(params[:id])
    @block.update(block_params)
    redirect_to discipline_path(params[:discipline_id]) 
  end
  
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to discipline_path(params[:discipline_id])
  end

  private
    
    def block_params
      params.require(:block).permit(:start, :finish)
    end

end
