class Notification < ActionMailer::Base
  default from: "no-reply@domainmonitour.com"

  def notify(user_id)
    @user = User.find(user_id)

    mail(:to => 'troy@drpcfix.com', :subject => 'Domain Expiring')
  end

end
