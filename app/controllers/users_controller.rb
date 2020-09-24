class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      flash.now[:error] = "An error prohibited your Profile from being saved: #{@user.errors.full_messages.join('. ')}."
      render :edit
    end
  end

  # is guest follewed by user
  def is_follow
	msg = @user.follow(@user.id) ? "Already following" : "followed"
  end
  
  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :nickname)
    end
end
