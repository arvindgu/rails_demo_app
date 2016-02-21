class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
   
    if user && user.authenticate(params[:session][:password])
       login_history=LoginHistory.find_by(user_id: user.id)
       login_history.last_login=DateTime.now
       login_history.save
       log_in user
       redirect_to user 
    else
       flash.now[:danger] = 'Invalid email/password combination'
       render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
