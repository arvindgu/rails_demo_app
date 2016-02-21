class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account ||= Account.find_by(user_id: session[:user_id])
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.user_id=session[:user_id]

    respond_to do |format|
      if @account.save
        transaction = Transaction.new
        transaction.user_id=session[:user_id]
        transaction.amount=@account.amount.to_f
        transaction.txn_type="CR"
        transaction.remarks="Account Open"
        transaction.save 

        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    previous_page = Rails.application.routes.recognize_path(request.referrer)[:controller]

    @account ||= Account.find_by(user_id: session[:user_id])
    if previous_page =~ /closeac/i
       if @account.status =! /closed/i
         @account.status='Closed'
         @account.save
   
         transactionCloseAccount = Transaction.new
         transactionCloseAccount.user_id = @account.user_id
         transactionCloseAccount.amount=0
         transactionCloseAccount.txn_type = "-"
         transactionCloseAccount.remarks ="Account Closed"
         transactionCloseAccount.save 
       end
    end
	
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :username, :password, :repassword, :amount, :address, :phone, :deposit_amount, :withdraw_amount, :transfer_amount)
    end
end
