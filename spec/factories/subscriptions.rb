# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :subscription do
    association :event
    association :user
  end
end
