Given /^I have (\d+) user registered$/ do |arg1|
  Identity.create(:name => "jane", :email => 'jane@doe.com', :password => "qwerty", :password_confirmation => "qwerty")
end

Given /^I am logged user$/ do
  FactoryGirl.create(:identity_jane)
end

