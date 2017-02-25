class Api::V1::SubscriptionsController < Api::V1::BaseController
  respond_to :json
  before_filter :authenticate_user!

  def create
    current_user.subscriptions.create!(event_id: params[:id].to_i)
    render json: { message: 'subscribed' }
  end

  def destroy
    current_user.subscriptions.where(event_id: params[:id].to_i).destroy_all
    render json: { message: 'unsubscribed' }
  end
end
