class DictionaryController < ApplicationController
  def search
    unless params.key? :tiles
      render :status => 400
      return
    end

    @words = DictionaryWord.find_scrabble_words params[:tiles]

    if @words.empty?
      render :status => 404
      return
    end

  end
end
