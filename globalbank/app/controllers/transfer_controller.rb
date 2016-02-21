class TransferController < ApplicationController
  def index
    @transactions = Transaction.where :user_id => session[:user_id]
  end

  def new
    @account ||= Account.find_by(user_id: session[:user_id])
    @transaction = Transaction.new
    @transaction.txn_type = "DR"
  end

  def create
    @transactioFrom = Transaction.new(transaction_params)
    @transactionFrom.user_id=session[:user_id]
    to_user_id = params['transaction']['to_user_id'].to_i    

      if @transaction.save
         @accountFrom ||= Account.find_by(user_id: session[:user_id])
         @accountTo ||= Account.find_by(user_id: to_user_id)

         @accountFrom.amount= @account.amount.to_f - @transaction.amount.to_f
         @accountTo.amount= @account.amount.to_f + @transaction.amount.to_f

         @accountFrom.save
         @accountTo.save

         transactionTo = Tranaction.new
         transactionTo.user_id = to_user_id
         transactionTo.amount=@trasactioFrom.amount
         transactionTo.remarks ="Amount Transferred from User ID #{@transactionFrom.user_id}"
         transactionTo.save
        
        redirect_to '/balance/show'
      else
        render :new
      end

  end

   private

  def transaction_params
      params.require(:transaction).permit(:user_id, :amount, :txn_type, :remarks, :created_at, :to_user_id)
  end

end
