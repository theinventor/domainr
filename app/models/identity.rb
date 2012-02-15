class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name,
            :presence => true
  validates :email,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
end

# == Schema Information
#
# Table name: identities
#
#  id              :integer         primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :timestamp
#  updated_at      :timestamp
#

