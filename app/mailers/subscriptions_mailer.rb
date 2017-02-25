class SubscriptionsMailer < ApplicationMailer
  default from: 'hello@skedge.com'

  def send_upcoming_event(user, event)
    @event = event
    mail(to: user.email, subject: "#{event.title} is starting very soon!" )
  end
end
