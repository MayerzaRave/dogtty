class CaresController < ApplicationController
  before_action :set_pet, only: %i[new create]

  def new
    @care = Care.new
  end

  def create
    @care = Care.new(care_params)
    @care.pet = @pet
    if @care.save
      redirect_to root_path, notice: 'care was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def care_params
    params.require(:care).permit(:pet_id, :category, :schedule, :status, :title, :details)
  end

end
