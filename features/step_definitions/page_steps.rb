
When(/^I visit the homepage$/) do
  visit '/' 
end

When(/^I fill in the letters "(.*?)" into the form$/) do |letters|
  fill_in 'Tiles', :with => letters
end

When(/^I fill in the mask "(.*?)" into the form$/) do |letters|
  fill_in 'Space on board', :with => letters
end


When(/^search for words$/) do
  click_button('Search')
end

Then(/^I should see the following words:$/) do |table|

  actual = []
  all(:css, 'ol li').each do |element| 
    actual.push({"Word" => element.find('.word').text, "Score" => element.find('.score').text})
  end
  
  actual.each_with_index do |item, index| 
    item.should == table.hashes[index]
  end

end

