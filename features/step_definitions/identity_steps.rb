Given /^I have (\d+) user registered$/ do |arg1|
  Identity.create(:name => "jane", :email => 'jane@doe.com', :password => "qwerty", :password_confirmation => "qwerty")
end

Given /^I am logged user$/ do
  FactoryGirl.create(:identity_jane)
end

Given /^I am logged in$/ do
  Identity.create(:name => "jane", :email => 'jane@doe.com', :password => "qwerty", :password_confirmation => "qwerty")
  visit root_path
  fill_in "Email", :with => 'jane@doe.com'
  fill_in "Password", :with => "qwerty"
  click_button "Login"
end