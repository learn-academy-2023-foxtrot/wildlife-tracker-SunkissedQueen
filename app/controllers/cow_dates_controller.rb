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

  def update
    date = CowDate.find(params[:id])
    date.update(date_params)
    if date.valid?
      render json: date
    else
      render json: date.errors
    end
  end

  def destroy
    date = CowDate.find(params[:id])
    dates = CowDate.all
    date.destroy
    if date.valid?
      render json: dates
    else
      render json: date.errors
    end
  end

  private
  def date_params
    params.require(:cow_date).permit(:cow_tipping_id, :cow_name, :date, :match)
  end
end
