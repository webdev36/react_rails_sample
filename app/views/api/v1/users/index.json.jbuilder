json.array! @users do |user|
  json.call(user,
            :id,
            :username)

  if current_user
    json.is_following current_user.following?(user)
  else
    json.is_following false
  end

  json.followers user.followers.size
  json.profile_pic user.image_url
  json.real_name user.name

  json.type 'User'
end
