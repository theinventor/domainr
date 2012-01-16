class Domain < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id, :domain
  validates_uniqueness_of :domain, :scope => :user_id

  default_scope :order => 'expiration_date ASC'


  def check_domain_now
    w = Whois.whois(self.domain)
    #rescue Whois::Error => self.check_domain_now
    self.registration_date = w.created_on
    self.expiration_date = w.expires_on
    self.save
    puts "DID A CHECK FROM MODEL"
  end

  def run_cron_now
    Rake::Task["cron"].execute
  end


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

