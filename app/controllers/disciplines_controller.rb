class DisciplinesController < ApplicationController
  
  def index
    Block.clean
    @disciplines = Discipline.all
    @summary = Discipline.summary
  end

  def clean
    Discipline.clean
    redirect_to disciplines_path
  end

  def show
    @discipline = Discipline.find(params[:id])
  end
    
  def destroy
    @discipline = Discipline.find(params[:id])
    @discipline.destroy
    redirect_to disciplines_path
  end

  def new
  end

  def create
    @discipline = Discipline.new(discipline_params)
    @discipline.save
    redirect_to disciplines_path
  end

  private
    
    def discipline_params
      params.require(:discipline).permit(:title)
    end

end
