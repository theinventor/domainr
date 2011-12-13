class ImportController < ApplicationController
  def godaddy
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
          foo = Domain.new(:domain => a.split(",")[0].split(" ")[5], :user_id => current_user.id)
          checker = Domain.find_by_domain(a.split(",")[0])
          if checker then puts "Found it" else foo.save(:validate => true) end

        else
          if a.split(",")[0].include?("</html>") then puts "skipping last row"
          else
            foo = Domain.new(:domain => a.split(",")[0], :user_id => current_user.id)
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
