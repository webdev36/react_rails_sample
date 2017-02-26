class Api::V1::EventsController < Api::V1::BaseController
  respond_to :json

  def index
    @events = Event.page(params[:page]).per(20).order('scheduled_at ASC').where('lower(title) like ?', "%#{params[:search_term].to_s.downcase}%")
    respond_with(@events)
  end

  def create
    event = Event.new(event_params)
    event.user = current_user
    if event.valid?
      event.save
      render json: event
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])

    if current_user.nil? || event.user != current_user
      return render nil
    end

    event.update(event_params)

    if event.valid?
      event.save
      render json: event
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    event_params = params.require(:event).permit(:title,
                                                 :caption,
                                                 :link,
                                                 :scheduled_at)
    unless event_params[:scheduled_at].blank?
      p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      p Chronic.parse(event_params[:scheduled_at])
      p Chronic.parse(event_params[:scheduled_at]).utc
      event_params[:scheduled_at] = Chronic.parse(event_params[:scheduled_at])
    end

    event_params
  end
end
