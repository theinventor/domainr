task :cron => :environment do

  #if Time.now.hour == 0 # run at midnight
  #  @domains = Domain.all
  #  @domains.each do |d|
  #    if d.expiration_date < Time.now.to_date + 90.days
  #      if d.expiration_date > Time.now.to_date
  #        Notification.notify(d).deliver
  #      end
  #    end
  #  end
  #end

  #if Time.now.hour == 18 # run at midnight
    @users = User.all
    @users.each do |u|
      u.domains.each do |d|
        if d.expiration_date < (Time.now.to_date + 90.days)
          if d.expiration_date > Time.now.to_date
            Notification.notify(d.user_id).deliver
          end
        end
      end
    end
  #end




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