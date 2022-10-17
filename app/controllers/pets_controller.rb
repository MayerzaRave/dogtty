class PetsController < ApplicationController
  before_action :set_pet, only: :show

  def index
    @pets = Pet.all
  end

  def show

  end

  def new
    @pet = Pet.new
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

end
