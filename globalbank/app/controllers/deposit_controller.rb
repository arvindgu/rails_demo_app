class DepositController < ApplicationController
  def index
  end

  def new    
    @account ||= Account.find_by(user_id: session[:user_id])
    @transaction = Transaction.new
    @transaction.txn_type ="CR"
  end


  def create     
        @user = User.update(user_params) 
   
  end

  private
  
  def account_params
      params.require(:account).permit(:amount, :deposit_amount) 
  end

end
