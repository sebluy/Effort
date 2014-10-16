class DisciplinesController < ApplicationController

  def index
    @disciplines = Block.select(:discipline).distinct
  end

end
