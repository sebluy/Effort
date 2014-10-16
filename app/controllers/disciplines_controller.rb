class DisciplinesController < ApplicationController

  def index
    @disciplines = Discipline.all
  end

  def show
    @discipline = Discipline.find(params[:id])
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
