class DisciplinesController < ApplicationController

  def index
    @disciplines = Discipline.all
    @time_table = {}
    -6.upto(0) do |days_ago|
      @time_table[days_ago] = Discipline.daily_time_spent(days_ago.days)
    end
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
