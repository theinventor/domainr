require 'spec_helper'

describe Domain do
  context 'relationships' do
    it { should belong_to(:user) }
  end
  context 'validation' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:domain) }
#    it { should validate_uniqueness_of(:domain).scoped_to(:user_id) }
  end
end
