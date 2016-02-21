class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @login_history ||= LoginHistory.find_by(user_id: @user.id)
    @account ||= Account.find_by(id: session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      login_history=LoginHistory.new
      login_history.user_id=@user.id
      login_history.last_login=@user.created_at
      login_history.save
      flash[:success] = "Welcome to the Global Bank!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
