require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: domains
#
#  id                :integer         primary key
#  domain            :string(255)
#  user_id           :integer
#  registration_date :date
#  expiration_date   :date
#  created_at        :timestamp
#  updated_at        :timestamp
#  alert_month       :boolean
#  alert_week        :boolean
#  alert_day         :boolean
#  page_html         :text
#  page_title        :string(255)
#  page_h1           :string(255)
#  page_h2           :string(255)
#  page_meta         :text
#  page_title_diff   :integer
#  page_html_diff    :integer
#  ip_address        :string(255)
#

