class Notification < ActionMailer::Base
  default from: "no-reply@domainmonitour.com"

  def weekly_notify(user_id)
    @user = User.find(user_id)
    mail(:to => 'troy@drpcfix.com', :subject => 'Domain expiring soon')
  end

    def daily_notify(user_id)
    @user = User.find(user_id)
    mail(:to => 'troy@drpcfix.com', :subject => 'Domain expiring TOMORROW')
  end

end
