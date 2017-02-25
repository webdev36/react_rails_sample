json.array! @events do |event|
  json.call(event,
            :id,
            :title,
            :caption,
            :scheduled_at,
            :link,
            :slug)

  json.user event.user.username
  json.real_name event.user.name
  json.profile_pic event.user.image_url
  json.subscribers event.subscriptions.size

  if current_user
    json.subscribed_to_event event.subscriptions.where(user_id: current_user.id).any?
  else
    json.subscribed_to_event false
  end

  json.type 'Event'
end
