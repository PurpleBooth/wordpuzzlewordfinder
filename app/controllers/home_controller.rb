class HomeController < ApplicationController
 
  caches_action :index
 
  def index
    expires_in 30.minutes, :public => true
  end
end
