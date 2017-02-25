class Api::V1::FollowersController < Api::V1::BaseController
  respond_to :json
  before_filter :authenticate_user!

  def create
    user = User.find(params[:id])
    current_user.follow(user)
    current_user.save!
    render json: { message: 'following' }
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    current_user.save!
    render json: { message: 'unfollowing' }
  end
end
