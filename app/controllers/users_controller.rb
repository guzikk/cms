class UsersController < ApplicationController

  layout 'admin'
  before_action :check_login

  def index
    @user = User.sort
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was added"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "user data was updated"
      redirect_to(:action=>'index')
    else
      render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:notice] = "user #{user.first_name} #{user.last_name} was deleted"
    redirect_to(:action=>'index')
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :login, :email, :password, :password_confirmation )
  end

end
