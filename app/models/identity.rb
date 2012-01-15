class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :name
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
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

