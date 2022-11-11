class PlacesController < ApplicationController
  def index
    @places = Place.all
    @markers = @places.geocoded.map do |place|
      {
        name: place.name,
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "info_window", locals: { place: }),
        image_url: helpers.asset_url("marker.png")
      }
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.save
    redirect_to places_path, notice: 'care was successfully created!'
  end

  private

  def place_params
    params.require(:place).permit(:name, :contact, :address, :longitude, :latitude)
  end
end
