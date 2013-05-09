class DictionaryController < ApplicationController

  def search
    expires_in 24.hours, :public => true
  
    @tiles = ""
    @tiles = params[:tiles] if params.key? :tiles
    @mask = ""
    @mask = params[:mask] if params.key? :mask

    unless params.key?(:tiles) || params.key?(:mask)
      render :status => 400
      return
    end

    logger.debug "#{Time.now} ["+Process.pid.to_s + "] Began searching for mask ["+@mask+"] with tiles ["+@tiles+"]"
    started = Time.now
 
    if params.key?(:mask) && !params[:mask].empty? && params.key?(:tiles) && !params[:tiles].empty?
      @words = DictionaryWord.find_scrabble_words(params[:tiles], params[:mask])
    elsif params.key?(:mask) && !params[:mask].empty? && (!params.key?(:tiles) || params[:tiles].empty?)
      @words = DictionaryWord.find_scrabble_words(false, params[:mask])
    else
      @words = DictionaryWord.find_scrabble_words params[:tiles] 
    end
    
    logger.info "#{Time.now} ["+Process.pid.to_s + "] Searched for mask ["+@mask+"] with tiles ["+@tiles+"] in "+ (Time.now-started).to_s + " seconds"

    if @words.empty?
      render :status => 404
    end

  end
end
