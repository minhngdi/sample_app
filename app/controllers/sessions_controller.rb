class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      logged user
    else
      flash.now[:danger] = t ".flash.login_fail"
      render :new
    end
  end

  def logged user
    log_in user
    remember_me = params[:session][:remember_me]
    remember_me == Settings.remember_yes ? remember(user) : forget(user)
    redirect_to user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
