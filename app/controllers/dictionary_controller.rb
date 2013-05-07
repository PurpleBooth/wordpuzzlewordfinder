class DictionaryController < ApplicationController
  def search
    unless params.key? :tiles
      render :status => 400
      return
    end

    if params.key? :mask
      @words = DictionaryWord.find_scrabble_words(params[:tiles], params[:mask])
    else
      @words = DictionaryWord.find_scrabble_words params[:tiles] 
    end

    if @words.empty?
      render :status => 404
      return
    end

  end
end
