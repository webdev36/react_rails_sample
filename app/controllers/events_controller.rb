class EventsController < ApplicationController
  def new
  end

  def show
    @event = Event.find(params[:id])
    @scheduled_at = { scheduled_at: @event.scheduled_at }.to_json
  end

  def edit
    @event = Event.find(params[:id])
    return redirect_to root_path if !current_user || @event.user != current_user
  end

  def toggle_subscription
    return render json: { message: 'toggled' } unless current_user

    event = Event.find(params[:id])
    if current_user.subscriptions.where(event: event).any?
      current_user.subscriptions.where(event: event).destroy_all
    else
      current_user.subscriptions.create!(event: event)
    end
    redirect_to event_path(event.id, event.slug)
  end
end
