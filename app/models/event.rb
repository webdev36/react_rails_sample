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

class Event < ApplicationRecord
  scope :upcoming, -> { where('scheduled_at > ?', Chronic.parse('now')).where('scheduled_at < ?', Chronic.parse('30 minutes from now')) }

  belongs_to :user
  has_many :subscriptions

  validates :title, :scheduled_at, :link, :user, presence: true
  validate :scheduled_at_not_in_past

  validates :title, length: {maximum: 40}
  validates :caption, length: {maximum: 100}

  acts_as_url :title, sync_url: true, url_attribute: :slug

  private

  def scheduled_at_not_in_past
    if scheduled_at.present? && scheduled_at < Time.zone.now
      errors.add(:scheduled_at, "Can't schedule something in the past!")
    end
  end
end
