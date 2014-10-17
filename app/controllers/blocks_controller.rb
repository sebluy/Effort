class BlocksController < ApplicationController
  
  def index
    @blocks = Block.all.reverse_order
  end

  def start
    @discipline = params[:discipline_id]
    @block = Discipline.find(@discipline).blocks.
      create(:start => DateTime.now)
    redirect_to discipline_path(params[:discipline_id])
  end

  def finish
    Block.find(params[:id]).update(:finish => DateTime.now)
    redirect_to discipline_path(params[:discipline_id])
  end

  def edit
    @discipline_id = params[:discipline_id]
    @id = params[:id]
    @block = Block.find(@id)
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

  def create
    Discipline.find(params[:discipline_id]).blocks.create(block_params)
    redirect_to discipline_path(params[:discipline_id])
  end

  private
    
    def block_params
      params.require(:block).permit(:start, :finish)
    end

end
