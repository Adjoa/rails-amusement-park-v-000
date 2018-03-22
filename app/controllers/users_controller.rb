class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  
  def welcome
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path 
    end
  end

  def show
      @user = User.find(params[:id])
  end
  
  def update
    user = User.find(session[:user_id])
    attraction = Attraction.find(params[:user][:attraction_id])
    ride = Ride.create(user_id: user.id, attraction_id: attraction.id)
    
    message = ride.take_ride
    redirect_to user_path(user), notice: "#{message}"
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin, :attraction_id)
  end
  
  def require_login
    redirect_to root_path unless session.include? :user_id    
  end
end
