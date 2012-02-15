require 'spec_helper'

describe User do
  context 'relationships' do
    #has_many relationships
    it { should have_many(:domains) }
  end

  context 'validation' do

  end

  context 'data type' do
    
  end

end
