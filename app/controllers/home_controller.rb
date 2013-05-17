class HomeController < ApplicationController
 
  def index
    expires_in 24.hours, :public => true
  end
  
  def no_consonants
    expires_in 24.hours, :public => true
    render "index", :layout => 'no_consonants'
  end
end
