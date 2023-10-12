class CowDatesController < ApplicationController 
  def index
    dates = CowDate.all
    render json: dates
  end

  def show
    date = CowDate.find(params[:id])
    render json: date
  end

  def create
    date = CowDate.create(date_params)
    if date.valid?
      render json: date
    else
      render json: date.errors
    end
  end

  private
  def date_params
    params.require(:cow_date).permit(:cow_tipping_id, :cow_name, :date, :match)
  end
end
