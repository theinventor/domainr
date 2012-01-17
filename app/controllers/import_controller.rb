class ImportController < ApplicationController

#this class is just to go to sites and pull in domains
  def receive_mail
    mail_text = params[:text]
    mail_html = params[:html]
    user = User.find_by_email(params[:from])

    if mail_text
      mail = mail_text
    else
      mail = mail_html
    end

    if user                                     #only get in to this if we have that user..
      mail_array = mail.split(" ")              #lets just get every "word" and look for a domain!

      mail_array.each do |word|
        if /^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|co|me|COM|ORG|NET|MIL|EDU|CO|ME)$/.match(word)      #must be a domain!
          Domain.create domain: word, user_id: user.id
        end
      end
    end

    that_worked = true
    if that_worked
      head :ok
    else
      head 500
    end
  end

  def godaddy
    if current_user then
      require 'mechanize'
      a = Mechanize.new { |agent|  agent.user_agent_alias = 'Linux Firefox' }              #for some reason wouldn't work without a user agent
      page = a.get('https://idp.godaddy.com/login.aspx?SPKey=GDDCC-M1PWDCCWEB02&myaUrl=%2fPrintableDomainList.aspx&activeview=Domain&sa=')
      fo = page.form_with(:name => 'Form1')
      fo.field_with(:name=>"Login$userEntryPanel2$UsernameTextBox").value = params[:user]
      fo.field_with(:name=>"Login$userEntryPanel2$PasswordTextBox").value = params[:pass]
      fo.click_button
      page = a.get("https://dcc.godaddy.com/PrintableDomainList.aspx?activeview=Domain&sa=")
      page.search("nobr").each do |result|
        if result.text.include?(".") then
          domain_var = result.text
          foo = Domain.new(:domain => domain_var.downcase, :user_id => current_user.id)
          puts "Importing domain: #{domain_var.downcase}"
          foo.save(:validate => true)
        end
      end
    else
      redirect_to "/", notice: "Sorry, permission problem or something.."
    end


  end

  def domainsite
    if current_user then
      @login_info_user = params[:user]
      @login_info_pass = params[:pass]
      agent = Mechanize.new
      page = agent.get('https://www.domainsite.com/account/login.php?redir_location=/management/list_domain.php&select_term=&meta_include=&')
      form = page.forms.first
      form.acct_name = @login_info_user
      form.password = @login_info_pass
      #puts "Username: #{@login_info_user} and Password: #{@login_info_pass}"
      form.submit
      form.submit
      agent.get("https://www.domainsite.com/management/plain_list.php")
      body = agent.page.body
      temp_array1 = body.split("<br />")
      temp_array1.each do |a|
        if a.split(",")[0].include?("<html>") then
          domain_var = a.split(",")[0].split(" ")[5]
          foo = Domain.new(:domain => domain_var.downcase, :user_id => current_user.id)
          checker = Domain.find_by_domain(a.split(",")[0])
          if checker then puts "Found it" else foo.save(:validate => true) end
        else
          if a.split(",")[0].include?("</html>") then puts "skipping last row"
          else
            domain_var = a.split(",")[0]
            foo = Domain.new(:domain => domain_var.downcase, :user_id => current_user.id)
            checker = Domain.find_by_domain(a.split(",")[0])
            if checker then puts "Found it" else foo.save(:validate => true) end
          end
        end
      end
    else
      redirect_to "/", notice: "Sorry, permission problem or something.."
    end

  end

  def select
    if current_user then
      puts "hi"
    else
      redirect_to "/", notice: "Sorry, permission problem or something.."
    end

  end

end
