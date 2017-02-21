class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    #devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar) }
  end

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:notice] = "test msg"
  #   redirect_to new_user_session_path
  # end

  rescue_from CanCan::AccessDenied do |exception|
    puts "*************test****************"
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}
    render :file => "#{Rails.root}/public/404.html", :status => 403, :layout => false
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, :alert => exception.message }
      format.js
    end
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
     #redirect_to new_user_session_path, flash[:alert] => 'if you want to add a notice'
     ## if you want render 404 page
      #flash[:alert] = 'if you want to add a notice'
      render "devise/registrations/new"
      #redirect_to url_for(:controller => :sessions, :action => :new)
    end
  end
end
