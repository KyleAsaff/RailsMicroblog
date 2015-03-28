class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :force_www!

  # force www.*
  protected

  def force_www!
    if Rails.env.production? and request.host[0..3] != "www."
    redirect_to "#{request.protocol}www.#{request.host_with_port}#{request.fullpath}", :status => 301
    end
  end

  private

  	# Confirms logged-in user.
  	def logged_in_user
  		unless logged_in?
  			store_location
  			flash[:danger] = "Please log in."
  			redirect_to login_url
  		end
  	end
end