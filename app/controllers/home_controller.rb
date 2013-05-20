class HomeController < ApplicationController
 
  def index
    expires_in 24.hours, :public => true
  end
  
  def ws
    expires_in 24.hours, :public => true
  end
  
  def wd
    expires_in 24.hours, :public => true
  end
  
  def wdws
    expires_in 24.hours, :public => true
  end
end
