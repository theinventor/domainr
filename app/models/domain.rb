class Domain < ActiveRecord::Base
  validates_presence_of :user_id, :domain
  validates_uniqueness_of :domain

end
