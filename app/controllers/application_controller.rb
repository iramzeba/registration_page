class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user, unless: Proc.new {|c| c.request.format.json?}

  def authenticate_user
     if session[:user_id].blank?
         redirect_to sign_in_users_path
     end
  end
  def current_user
  	if session[:user_id] 
        User.find session[:user_id]
    else 
        nil
    end
  end
end