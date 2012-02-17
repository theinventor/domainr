require 'spec_helper'

describe Domain do
  before(:each) do
    @domain = FactoryGirl.create(:domain_google)
  end

  context 'relationships' do
    it { should belong_to(:user) }
  end

  context 'validation' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:domain) }
    it { should validate_uniqueness_of(:domain).scoped_to(:user_id) }
  end

  context 'whois address' do
    it "should registration and expiration date" do
      Whois.expects(:whois).returns(WhoIsMock.new)
      @domain.check_domain_now
      @domain.registration_date.strftime("%Y-%m-%d").should == "1997-09-14"
      @domain.expiration_date.strftime("%Y-%m-%d").should == "2020-09-12"
    end
  end
end
