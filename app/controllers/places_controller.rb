class PlacesController < ApplicationController
  def index
    @place = Place.new
    @place.name = 'test'

    @window = render_to_string(partial: "info_window", locals: { place: @place })
  end

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
    params.require(:place).permit(:care_id, :name, :address, :longitude, :latitude, :contact)
  end
end
