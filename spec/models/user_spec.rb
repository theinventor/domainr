require 'spec_helper'

describe User do
  before(:each) do
    @auth = {"provider" => "facebook", "uid" => "qwerty", "info" => {"name" => "john"}}
  end

  context 'relationships' do
    #has_many relationships
    it { should have_many(:domains) }
  end

  context 'validation' do

  end

  context 'login by omniauth' do
    it "should create user by oauth token" do
      User.from_omniauth(@auth)
      u = User.find_by_uid("qwerty")
      u.name.should == "john"
    end
    
    it "should find user by oauth token" do
      User.create_with_omniauth(@auth)
      u = User.find_by_uid("qwerty")
      u.name.should == "john"      
    end

  end

end
