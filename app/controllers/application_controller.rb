class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :resolve_layout

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private 
  def resolve_layout
    case action_name
    when "about"
      "about_layout"
    else 
      "application"
    end 
  end 
end
