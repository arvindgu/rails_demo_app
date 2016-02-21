class TransactionsController < ApplicationController

  def index
     @transactions = Transaction.where :user_id => session[:user_id]
  end

  def show
  end

  def deposit
    @account ||= Account.find_by(user_id: session[:user_id])
    @transaction = Transaction.new
    @transaction.txn_type = "CR"

  end

  def withdraw
    @account ||= Account.find_by(user_id: session[:user_id])
    @transaction = Transaction.new
    @transaction.txn_type = "DR"
  end


  def create
    previous_page = Rails.application.routes.recognize_path(request.referrer)[:controller]
    @transaction = Transaction.new(transaction_params)    
    @transaction.user_id=session[:user_id]
    to_user_id = params['transaction']['to_user_id'].to_i

      if @transaction.save
         @account ||= Account.find_by(user_id: session[:user_id])

        if @transaction.txn_type  =~ /CR/
           @account.amount= @account.amount.to_f + @transaction.amount.to_f
        else  @transaction.txn_type  =~ /DR/
           @account.amount= @account.amount.to_f - @transaction.amount.to_f
        end 
        @account.save

    transactionTo = Transaction.new
	transactionTo.user_id = to_user_id
	transactionTo.amount=@transaction.amount.to_f
    transactionTo.txn_type = "CR"
	transactionTo.remarks ="Amount Transferred from User ID #{session[:user_id]}"
	transactionTo.save

            
        redirect_to '/balance/show'
      else
        render :new
      end
  end

  private

  def transaction_params
      params.require(:transaction).permit(:user_id, :amount, :txn_type, :remarks, :created_at)
  end

end
