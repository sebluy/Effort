class DisciplinesController < ApplicationController

  def index

    @disciplines = Discipline.all
    @time_table = {}
    @plot_data = []
  
    0.upto(13) do |n|
      time = Discipline.daily_time_spent(n.days.ago)
      @time_table[-n] = time
      @plot_data.unshift([-n, time.length/3600.0])
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
