class WhoIsMock
  attr_reader :created_on, :expires_on
  def initialize()
    @created_on = "1997-09-14"
    @expires_on = "2020-09-12"
  end
end

Given /^I have (\d+) domains$/ do |arg1|
  Whois.expects(:whois).returns(WhoIsMock.new)
  FactoryGirl.create(:domain_google)
  FactoryGirl.create(:domain_facebook)
  FactoryGirl.create(:domain_twitter)
end