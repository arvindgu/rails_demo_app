class WithdrawController < ApplicationController
  def index
  end

  def new
    @account ||= Account.find_by(user_id: session[:user_id])
  end
end
