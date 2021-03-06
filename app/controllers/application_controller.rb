class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # use this to authorize devise if you need to lock down whole app with "after_action"
  # after_action :verify_authorized, unless: :devise_controller?


  protected 
	  def configure_permitted_parameters
	  	devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
	  	devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name]
	  end
end