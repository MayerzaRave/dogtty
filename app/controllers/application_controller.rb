class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name contact])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end


end
