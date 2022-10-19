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
  
  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id

    if @pet.save
      redirect_to @pet, notice: 'Pet was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end


  def new
    @pet = Pet.new
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :specie, :birthday, :photo, :weight, :breed)
  end
end
