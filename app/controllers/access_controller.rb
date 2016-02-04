class AccessController < ApplicationController

layout 'admin'
before_action :check_login, :except=>[:login, :loginin, :logout]

  def index
  end

  def login
  end

  def loginin
    if params[:login].present? && params[:password].present?
      admin_find = User.where(:login=>params[:login]).first
      if admin_find
        admin_authentication = admin_find.authenticate(params[:password])
      end
    end

    if admin_authentication
      session[:user_id] = admin_authentication.id
      session[:user] = admin_authentication.login
      flash[:notice] = "You have been properly logged in"
      redirect_to(:action=>'index')
    else
      flash[:notice] = "error, incorrect username or password"
      redirect_to(:action=>'login')
    end
end

  def logout
    session[:user_id] = nil
    session[:user]=nil
    flash[:notice]='You have been logged out'
    #redirect_to(:action=>login)
    redirect_to(:controller=>'public', :action=>'index')
  end

end