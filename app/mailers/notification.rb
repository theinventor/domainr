class Notification < ActionMailer::Base
  default from: "no-reply@domainmonitour.com"

  def notify(item)
    @item = item
    mail( :to => 'troy@drpcfix.com', :subject => 'Domain Expiring')
  end

end
