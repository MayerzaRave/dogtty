class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update]

  def index
    @pets = Pet.all
    @scheduled = Care.where(status: 'scheduled').count
    @missed = Care.where(status: 'missed').count
    @at_time = Care.where(status: 'completed at time').count
    @out_time = Care.where(status: 'completed out of time').count
    @stats = { "Scheduled" => @scheduled,
               "Missed and rescheduled" => @missed,
               "Completed at time" => @at_time,
               "Completed out of time" => @out_time }

    # @desease = Desease.new
  end

  def show
    @pet = Pet.find(params[:id])
    @cares = Care.where(pet_id: @pet)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "pet",
               template: "pets/show",
               formats: [:pdf],
               disposition: 'attachment',
               layout: "pdf",
               locals: { pet: @pet }
      end
    end
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

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :specie, :birthday, :photo, :weight, :breed)
  end
end
