# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  title        :text
#  caption      :text
#  scheduled_at :datetime
#  link         :text
#  user_id      :integer
#  slug         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| Faker::Commerce.department(5) + n.to_s }
    caption 'Lots of food and fun!'
    scheduled_at { Time.now + 2.days }
    link 'http://google.com'
    association :user
  end
end
