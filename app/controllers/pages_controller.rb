class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # start_date = params.fetch(:schedule, Date.today).to_date
    # @cares = Care.where(schedule: start_date.beginning_of_week..start_date.end_of_week)
    @cares = Care.all
  end
end
