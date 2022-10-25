class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    # start_date = params.fetch(:schedule, Date.today).to_date
    # @cares = Care.where(schedule: start_date.beginning_of_week..start_date.end_of_week)
    if user_signed_in?

      @cares = current_user.cares
      @cares = @cares.select { |care| care.status == 'scheduled' }
    else
      @cares = []
    end
  end

  def about
  end
end
