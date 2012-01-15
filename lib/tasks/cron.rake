task :cron => :environment do


  #re-check domains that are within 7 days of expiring
  #for now, we'll just clear the expiration date out so that it gets re-checked at bottom
  #we want to only do this if its been over a week since the domain was updated
  if Time.now.to_date.strftime('%A') == "Saturday" # run weekly on Saturday
    if Time.now.hour == 0 # run at midnight
      @domains = Domain.all                   #refactor this to a nice .where with date range
      @domains.each do |d|
        if d.expiration_date < (Time.now.to_date + 8.days)
          if d.updated_at < (Time.now - 9.days)
            d.expiration_date = ""
            d.save
          end
        end
      end
    end
  end

  #do the daily notifications for the following day - every night at midnight
  if Time.now.hour == 0 # run at midnight
    @users = User.all
    @users.each do |u|
      mail_them = false
      u.domains.each do |d|
        if d.expiration_date < (Time.now.to_date + 2.days)
          if d.expiration_date > Time.now.to_date
            mail_them = true
          end
        end
      end
      if mail_them == true
        Notification.daily_notify(u.id).deliver
        puts "email sending to #{u.name}" if u.name
      end
    end
  end

  #do the weekly Friday notifications
  if Time.now.to_date.strftime('%A') == "Friday" # run weekly on Friday
    if Time.now.hour == 0 # run at midnight
      @users = User.all
      @users.each do |u|
        mail_them = false
        u.domains.each do |d|
          if d.expiration_date < (Time.now.to_date + 60.days)
            if d.expiration_date > Time.now.to_date
              mail_them = true
            end
          end
        end
        if mail_them == true
          Notification.weekly_notify(u.id).deliver
          puts "email sending to #{u.name}" if u.name
        end
      end
    end
  end




  domains = Domain.all
  domains.each do |d|
    if d.expiration_date.nil? then
      d.domain = d.domain.downcase
      w = Whois.whois(d.domain)
      d.registration_date = w.created_on
      puts w.created_on
      puts w.expires_on
      d.expiration_date = w.expires_on
      d.save!
    else
      #puts "skipping"
    end
  end
end