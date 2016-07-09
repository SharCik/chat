class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def not_banned_user!

    unless current_user.ban != true
      flash[:ban] = "You are banned!"
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password,
      :password_confirmation, :remember_me, :picture) }
  end

end