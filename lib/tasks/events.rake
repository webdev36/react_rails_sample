namespace :events do
  task notify: :environment do
    puts "Sending notifications for upcoming events."
    Event.upcoming.find_each do |event|
      subscribed_users = event.subscriptions.map(&:user)
      following_users = event.user.followers
      notify_user = (subscribed_users + following_users).uniq

      notify_user.each do |user|
        SubscriptionsMailer.send_upcoming_event(user, event).deliver_now
      end

    end
  end
end
