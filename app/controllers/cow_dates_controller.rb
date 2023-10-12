class CowDatesController < ApplicationController 
  def index
    dates = CowDate.all
    render json: dates
  end

  def show
    date = CowDate.find(params[:id])
    render json: date
  end
end
