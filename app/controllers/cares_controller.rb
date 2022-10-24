class CaresController < ApplicationController
  before_action :set_pets, only: :new
  before_action :set_care, only: %i[new create]

  def new
    @care = Care.new
  end

  def create
    @pets_id = params[:care][:pet_id]

    @pets_id[1, @pets_id.size].each do |id|
      @care = Care.new(care_params)
      @care.pet = Pet.find(id.to_i)
      @care.save 
    end
    redirect_to root_path, notice: 'care was successfully created!'
  end

  private

  def set_pets
    @pets = Pet.where(user: current_user)
  end

  def care_params
    params.require(:care).permit(:pet_id, :category, :schedule, :status, :title, :details)
  end

  def set_care
    @care = Care.new
    @care.title = params[:care]
  end
end
