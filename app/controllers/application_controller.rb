class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to root_url, :alert => exception.message
  # end
   
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
    u.permit(:email, :password, :password_confirmation, :fname, :lname, :dob, :mobile, :gender, :address, :city)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
    u.permit(:email, :password, :password_confirmation,:current_password, :fname, :lname, :dob, :mobile, :gender, :address, :city)
    end
  end  
end
