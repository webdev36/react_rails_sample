class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def toggle_following
    return render json: { message: 'toggled' } unless current_user

    user = User.find(params[:id])
    if current_user.following?(user)
      current_user.unfollow(user)
    else
      current_user.follow(user)
    end
    current_user.save!
    redirect_to user_path(user.id, user.username)
  end
end
