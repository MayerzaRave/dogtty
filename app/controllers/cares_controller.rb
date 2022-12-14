class CaresController < ApplicationController
  before_action :set_pets, only: :new
  before_action :set_care, only: %i[show edit update destroy]
  before_action :set_category_and_title, only: :new

  def new
    # raise
    @care = Care.new
  end

  def show
    @pet = Pet.find(Care.find(params[:id]).pet_id)
  end

  def index
    # @cares = Care.all
    # @pets = Pet.where(user_id: current_user.id)
    # @places =
    # @markers = @places.geocoded.map do |place|
    #   {
    #     lat: place.latitude,
    #     lng: place.longitude
    #   }
    # end

    if params[:query].present?
      @cares = Care.where("title ILIKE ?", "%#{params[:query]}%")

    else
      @cares = current_user.cares
    end

    @cares.each do |care|
      if care.status == "scheduled" && care.schedule < Time.now
        care.status = 'missed'
        care.save
      end
    end
  end

  def destroy
    @care.destroy
    redirect_to cares_path, notice: 'Care was successfully destroyed!'
  end

  def edit
  end

  def update
    if params[:status]
      if @care.status == 'scheduled'
        @care.status = 'completed at time'
      else
        @care.status = "completed out of time"
      end
      @care.update(params.permit(:data))

    else

      @care.update(care_params)
    end
    redirect_to root_path, notice: 'care was successfully updated!'
  end

  def create
    @pets_id = params[:care][:pet_id]

    @pets_id[1, @pets_id.size].each do |id|
      @care = Care.new(care_params)
      @care.pet = Pet.find(id.to_i)
      @care.status = 'scheduled'
      @care.save
    end
    redirect_to root_path, notice: 'care was successfully created!'
  end

  private

  def set_pets
    @pets = Pet.where(user: current_user)
  end

  def set_care
    @care = Care.find(params[:id])

    if @care.status == "scheduled" && @care.schedule < Time.now
      @care.status = 'missed'
      @care.save
    end

  end

  def care_params
    params.require(:care).permit(:pet_id, :place_id, :category, :schedule, :status, :title, :details)
  end

  def set_category_and_title
    @category = params[:category]
    @title = params[:title]

    if @category && @title

      CATEGORIES.delete_at(CATEGORIES.find_index(@category))
      CATEGORIES.insert(0, @category)

      CARES.delete_at(CARES.find_index(@title))
      CARES.insert(0, @title)
    end
  end
end
