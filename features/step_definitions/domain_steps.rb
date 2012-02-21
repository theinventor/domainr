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

Then /^I should see domains "([^"]*)", "([^"]*)", "([^"]*)"$/ do |arg1, arg2, arg3|
  body = Nokogiri::HTML(page.body)
  text = []
  body.xpath('//tr/td[1]').each{|x| text << x.text}
  text[0].should == arg1
  text[1].should == arg2
  text[2].should == arg3
end