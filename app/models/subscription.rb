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

class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates_uniqueness_of :event_id, scope: :user_id
end
