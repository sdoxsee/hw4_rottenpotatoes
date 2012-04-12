# Add a declarative step here for populating the DB with movies.

# require 'ruby-debug'

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.new(movie)
    m.save!
  end
  # assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # assert false, "Unimplmemented"
  # page.body
  assert (page.body =~ /#{e1}(.*)#{e2}/m) >= 0
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.to_s.split(/, */).each do |rating|
    step 'I ' + (uncheck ? "uncheck" : "check") + ' "ratings[' + rating.strip + ']"'
  end  
end

Then /I should see all of the movies/ do 
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # assert false, "Unimplmemented"
  movies = Movie.find(:all)
  # movies.each do |movie|
  assert page.has_xpath?('.//table[@id="movies"]/tbody/tr', :count => movies.size)
  # result.should == true
end

Then /the director of "(.+)" should be "(.+)"/ do |title, director|
  m = Movie.find_by_title(title)
  assert (m.director == director)
  assert (page.body =~ /#{director}/) >= 0 
end