require 'spec_helper'

describe DictionaryController do

  describe "GET 'search'" do
    before do
      %w(act CAT TAC GAT CHAT IT PETTLE).each do |word|
        item = DictionaryWord.new
        item.word = word
        item.save
      end
    end

    it "returns http success with a valid item to search for with a mask" do
      get('search', {'tiles' => "TAC", 'mask' => "?A?"})
      response.should be_success
    end

    it "returns http success with a valid item to search for" do
      get('search', {'tiles' => "TAC"})
      response.should be_success
    end

    it "returns http 404 when it can't find any matching tiles" do
      get('search', {'tiles' => "QXQ"})
      response.response_code.should == 404
    end

    it "returns http 400 when there isn't an tiles parameter" do
      get('search')

      response.response_code.should == 400
    end
  end

end
