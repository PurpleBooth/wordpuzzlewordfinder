class DictionaryController < ApplicationController

  caches_action :search

  def search
    expires_in 30.minutes, :public => true
  
    unless params.key?(:tiles) || params.key?(:mask)
      render :status => 400
      return
    end

    @tiles = params[:tiles] if params.key? :tiles
    @tiles = ""
    @mask = ""

    if params.key?(:mask) && !params[:mask].empty? && params.key?(:tiles) && !params[:tiles].empty?
      @mask = params[:mask]
      @words = DictionaryWord.find_scrabble_words(params[:tiles], params[:mask])
    elsif params.key?(:mask) && !params[:mask].empty? && (!params.key?(:tiles) || params[:tiles].empty?)
      @mask = params[:mask]
      @words = DictionaryWord.find_scrabble_words(false, params[:mask])
    else
      @words = DictionaryWord.find_scrabble_words params[:tiles] 
    end

    if @words.empty?
      render :status => 404
      return
    end

  end
end
