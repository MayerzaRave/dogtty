class CaresController < ApplicationController
  before_action :set_pets, only: :new

  def new
    @care = Care.new
  end

  def show
    @care = Care.find(params[:id])
    @pet = Pet.find(Care.find(params[:id]).pet_id)
  end
  
  def index
    @cares = Care.all
    @pets = Pet.where(user_id: current_user.id)
  end

  def destroy
    @care = Care.find(params[:id])
    @care.destroy
  end

  def update
    @care = Care.find(params[:id])
    @care.update(status: "Accomplished", title: care_params(:other))
    redirect_to cares_path, notice: 'Service was successfully updated!'
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

  def care_params(element)
    object = params.require(:care).permit(:pet_id, :category, :schedule, :status, :title, :details, :other)
    object[element]
  end
end