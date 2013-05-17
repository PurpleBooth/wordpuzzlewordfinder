class HomeController < ApplicationController
 
  def index
    @original = true
    expires_in 24.hours, :public => true
  end
  
  def no_consonants
    expires_in 24.hours, :public => true
    render "index", :layout => 'no_consonants'
  end
  
  def blurb_text_missing
    expires_in 24.hours, :public => true
  end
  
  def no_consonants_no_blurb
    expires_in 24.hours, :public => true
    render "blurb_text_missing", :layout => 'no_consonants'
  end
end
