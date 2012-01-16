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

  #do the daily EXPIRATION notifications for the following day - every night at midnight
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

  #do the daily OUTAGE notifications for the day - every night at 4am
  if Time.now.hour == 4 # run at midnight
    @users = User.all
    @users.each do |u|
      mail_them = false
      u.domains.each do |d|
        if d.page_title_diff
          if d.page_title_diff > 0
            mail_them = true
          end
        end
      end
      if mail_them == true
        Notification.daily_outage(u.id).deliver
        puts "outage email sending to #{u.name}" if u.name
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



  #check the expiration dates for any domain that doesn't have it, this happens with every cron run - hourly ATM
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

  #check periodically (daily) for HTML content to make sure page is rendering
  #save some basic diff info into the model so we can alert on major changes/outages

  #if Time.now.hour == 0 # run at midnight
  require 'open-uri'
  require 'resolv'

  @domains = Domain.all
  @domains.each do |d|
    url = "http://www." + d.domain
    begin
      doc = Nokogiri::HTML(open(url))
      ip_address = Resolv.getaddress(d.domain)
    rescue
      puts "Failed lookup"
    else

      #do the H1 tag
      if d.page_html
        puts "in the first page_html if"
        if doc
          puts "in the first if doc!"
          d.page_h1 = doc.css("h1").text
        end
      else
        d.page_h1 = doc.css("h1").text
      end

      #do the TITLE tag
      if d.page_html
        if doc.css("title")
          d.page_title_diff = d.page_title.length - doc.css("title").text.length           #diff is current title length minus actual title length, as percentage
                                                                                           #percent_base = 100 / d.page_title.length                                #figure out percentages  "29" ==   3.4
                                                                                           #diff_var1 = 100 / d.page_title_diff                                   #change by "14"
                                                                                           #percent_diff = d.page_title_diff * percent_base                        #this should be a percent of difference

          d.page_title = doc.css("title").text
        end
      else
        d.page_title = doc.css("title").text
      end

      #do the H2 tag
      if d.page_html
        if doc.css("h2")
          d.page_h2 = doc.css("h2").text
        end
      else
        d.page_h2 = doc.css("h2").text
      end

      #do the META tags
      #if d.page_html
      #  if doc.at_css("meta")
      #    d.page_meta = doc.at_css("meta").text
      #    #d.save
      #  end
      #else
      #  d.page_meta = doc.at_css("meta").text
      #  puts doc.at_css("meta")
      #end

      #load the page after diffs are checked
      if d.page_html
        if doc
          d.page_html = doc.to_s
        end
      else
        d.page_html = doc.to_s
      end

      #for now we'll just store the IP we found '                               #add a check for this!
      d.ip_address = ip_address if ip_address
      d.save
      puts "Saving page for: #{d.domain}"       #debug
    end
  end



end
#debug text to copy/paste into rails c
#require 'open-uri'
#url = "http://drpcfix.com"
#@doc = Nokogiri::HTML(open(url))