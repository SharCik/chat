class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show
  	
  end


  def edit
  		@user = current_user
  end


  def update
	  @user = current_user	
      if @user.update!(user_params)
        flash[:notice] = "User updated."
        redirect_to profile_path
      else
        flash[:error] = "Could not update user."
        render :edit
      end
  end

  def setBan
    user = User.find(params[:user_id])
    user.ban = true
    user.save!
    redirect_to users_path
  end

  def removeBan
    user = User.find(params[:user_id])
    user.ban = false
    user.save!
    redirect_to users_path
  end

private
    def user_params
       params.require(:user).permit(:name, :picture)
    end


end
