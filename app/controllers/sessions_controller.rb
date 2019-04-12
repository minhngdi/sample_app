class SessionsController < ApplicationController

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      if user.activated?
        authorize user
      else
        not_authorize
      end
    else
      flash.now[:danger] = t ".flash.login_fail"
      render :new
    end
  end

  def logged user
    log_in user
    remember_me = params[:session][:remember_me]
    remember_me == Settings.remember_yes ? remember(user) : forget(user)
    redirect_back_or user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def authorize user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  def not_authorize
    message = t ".account_not_active"
    message += t ".check_active_link"
    flash[:warning] = message
    redirect_to root_url
  end
end
