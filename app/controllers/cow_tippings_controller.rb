class CowTippingsController < ApplicationController

  def index
    cows = CowTipping.all
    render json: cows
  end

  def show
    cow = CowTipping.find(params[:id])
    render json: cow
  end

  def create
    cow = CowTipping.create(cow_params)
    if cow.valid?
      render json: cow
    else
      render json: cow.errors
    end
  end

  private
  def cow_params
    params.require(:cow_tipping).permit(:name, :breed, :farm)
  end
end
