class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
  @user = User.find_by({ "email" => params["email"] })

  if @user
    if BCrypt::Password.new(@user["password"]) == params["password"]
      session["user_id"] = @user["id"]
      flash["notice"] = "Welcome, #{@user["username"]}."
      redirect_to "/places"
    else
      flash["notice"] = "Incorrect password."
      redirect_to "/login"
    end
  else
    flash["notice"] = "Email not found."
    redirect_to "/login"
  end
end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
