class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json

  def index
    @users = User.page(params[:page]).per(20).where('lower(username) like ?', "%#{params[:search_term].to_s.downcase}%")
    respond_with(@users)
  end
end
