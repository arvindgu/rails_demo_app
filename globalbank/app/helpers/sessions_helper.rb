module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

 # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end 

  def not_have_account?
    Account.find_by(user_id: session[:user_id]).nil?    
  end

  def is_account_closed?
     account = Account.find_by(user_id: session[:user_id])
     if !account.nil?
       account.status =~ /closed/i
     end
  end  

end
