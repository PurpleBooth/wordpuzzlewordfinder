class HomeController < ApplicationController
 
  def index
    expires_in 24.hours, :public => true
  end
end
