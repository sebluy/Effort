class BlocksController < ApplicationController
  
  def index
    @blocks = Block.all.reverse_order
  end

  def new
    @discipline_id = params[:discipline_id]
  end
  
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to discipline_path(params[:discipline_id])
  end

  def create
    @discipline = Discipline.find(params[:discipline_id])
    @block = @discipline.blocks.create(block_params)
    @block.save
    redirect_to discipline_path(params[:discipline_id])
  end

  private
    
    def block_params
      params.require(:block).permit(:discipline_id, :start, :finish)
    end

end
