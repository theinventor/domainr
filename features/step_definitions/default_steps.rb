Given /^I have no account$/ do
  Capybara.reset_sessions!
end

Given /^I am on the front page$/ do
  visit root_path
end

When /^I follow "([^"]*)"$/ do |link_text|
  click_link link_text
end

When /^I fill "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in field, :with => value
end

When /^I choose "([^"]*)"$/ do |radio_button|
  choose radio_button
end

When /^I check "([^"]*)" checkbox$/ do |checkbox|
  check checkbox
end

When /^I press "([^"]*)"$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end

Then /^I should not see "([^"]*)"$/ do |text|
  page.should_not have_content text
end

Then /^I should be on "([^"]*)" page$/ do |title|
  page.should have_xpath("//title", :text => title)
end

When /^I debug$/ do
  require "ruby-debug"
  debugger
  page
end
