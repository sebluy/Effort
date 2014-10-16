class BlocksController < ApplicationController
  
  def index
    @blocks = Block.all.reverse_order
  end

  def new
  end
  
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to blocks_path
  end

  def create
    @block = Block.new(block_params)
    @block.save
    redirect_to blocks_path
  end

  private
    
    def block_params
      params.require(:block).permit(:discipline, :start, :finish)
    end

end
