require 'spec_helper'

describe DictionaryWord do

  describe ".new" do
    it "should create a new instance" do
      DictionaryWord.new
    end
  end

  describe "#word" do    
    before do
      @word = DictionaryWord.new
    end

    it "can set a word" do
      @word.word = "Example"
      @word.word.should eq("Example")
    end
  end

  describe "#score" do    
    before do
      @word = DictionaryWord.new
    end

    it "returns the words with friends score of the word" do
      @word.word = "Example"
      @word.score.should eq(1+8+1+4+4+2+1)
    end
  end

  describe "#to_s" do    
    before do
      @word = DictionaryWord.new
    end

    it "returns the word" do
      @word.word = "Example"
      @word.word.to_s.should eq("Example")
    end
  end

  describe ".find_scrabble_words" do
    before do
      %w(ACT CAT TAC GAT CHAT IT PETTLE ULU).each do |word|
        item = DictionaryWord.new
        item.word = word
        item.save
      end

    end

    it "Finds words in the dictionary you can spell with the tiles given" do
      actual = []
      DictionaryWord.find_scrabble_words("CAT").each do |item|
        actual.push item.to_s
      end

      actual.should eq ["ACT", "CAT", "TAC"]
    end

    it "Finds words in the dictionary you can spell with the tiles given even if one of those is a blank" do
      actual = []
      DictionaryWord.find_scrabble_words("C T").each do |item|
        actual.push item.to_s
      end

      actual.should eq ["ACT", "CAT", "TAC", "IT"]
    end
    
    
    it "lets you set a mask to limit what you get back" do
      actual = []
      DictionaryWord.find_scrabble_words("C T", "?A?").each do |item|
        actual.push item.to_s
      end

      actual.should eq ["CAT", "TAC", "GAT"]
    end

    it "Only lets you use a blank once" do
      actual = []
      DictionaryWord.find_scrabble_words(" CRABBLE").each do |item|
        actual.push item.to_s
      end

      actual.should eq ["ACT", "CAT", "TAC"]
    end


    it "case insensitive" do
      actual = []
      DictionaryWord.find_scrabble_words(" crabble").each do |item|
        actual.push item.to_s
      end

      actual.should eq ["ACT", "CAT", "TAC"]
    end
  end
end
