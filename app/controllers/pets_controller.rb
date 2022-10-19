class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update]

  def index
    @pets = Pet.all
  end

  def show
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :specie, :birthday, :photo, :weight, :breed)
  end
end
