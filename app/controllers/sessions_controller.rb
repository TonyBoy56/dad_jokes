class SessionsController < ApplicationController
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "You've signed in foo."
      session[:user_id] = @user.user_id
      redirect_to "/"
    else
      flash[:alert] = "There was a problemo signing in foo. Try again."
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "See ya later alligator."
    redirect_to "/"
  end
end