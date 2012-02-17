require 'spec_helper'

describe Identity do
  before(:each) do
    @identity = Identity.create(:name => "john", :email => 'address@example.com', :password => "qwerty", :password_confirmation => "qwerty")
  end
  
  context 'relationships' do
    
  end
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_format_of(:email).with('john@doe.com') }
  end
end
