class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private

  	# Confirms logged-in user.
  	def logged_in_user
  		unless logged_in?
  			store_location
  			flash[:danger] = "Please login."
  			redirect_to login_url
  		end
  	end
end
