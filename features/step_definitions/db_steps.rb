Given(/^I have loaded the dictionary$/) do
  %w(ACT CAT TAC FAT TAT GOT).each do |word|
    item = DictionaryWord.new
    item.word = word
    item.save
  end
end
