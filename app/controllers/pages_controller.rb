class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @pet = Pet.where(user: current_user).first
  end
end
