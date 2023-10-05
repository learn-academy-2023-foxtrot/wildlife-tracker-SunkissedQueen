class CowTippingsController < ApplicationController

  def index
    cows = CowTipping.all
    render json: cows
  end

end
