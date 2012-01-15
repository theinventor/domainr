class User < ActiveRecord::Base
  has_many :domains

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end


end

# == Schema Information
#
# Table name: users
#
#  id         :integer         primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#

