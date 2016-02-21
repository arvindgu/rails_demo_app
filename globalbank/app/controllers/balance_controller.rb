class BalanceController < ApplicationController
  def show
    @account ||= Account.find_by(user_id: session[:user_id])
    @user ||= User.find_by(id: session[:user_id])
    @transactions = Transaction.where :user_id => session[:user_id]
  end
end
