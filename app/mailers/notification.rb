class Notification < ActionMailer::Base
  default from: "no-reply@domainmonitour.com"

  def weekly_notify(user_id)
    @user = User.find(user_id)
    if @user.email
      mail(:to => @user.email, :subject => 'Domain expiring soon')
    end
  end

  def daily_notify(user_id)
    @user = User.find(user_id)
    if @user.email
      mail(:to => @user.email, :subject => 'Domain expiring TOMORROW')
    end
  end

end
