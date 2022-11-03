class PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.save
    redirect_to cares_path, notice: 'care was successfully created!'
  end

  private

  def place_params
    params.require(:place).permit(:care_id, :name, :address, :contact)
  end
end
