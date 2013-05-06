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
end
