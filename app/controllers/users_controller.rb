class UsersController < ApplicationController
#this is really just here to modify the notification email after signed in

  def edit
    if current_user                                 #make sure logged in
      if current_user.id == params[:id]             #make sure they want to edit themselves?
        @user = User.find(current_user.id)
      end
    end
  end

  def update
    if current_user                                 #make sure logged in
      if current_user.id == params[:id]             #make sure they want to edit themselves?
        @user = User.find(params[:id])

        respond_to do |format|
          if @user.update_attributes(params[:comment])
            format.html { redirect_to("/", :notice => 'Notification email was successfully updated.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
          end
        end
      end
    end
  end

end
