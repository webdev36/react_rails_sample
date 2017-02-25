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

require 'rails_helper'

describe Subscription do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:subscription)).to be_valid
    end
  end

  describe 'Model Validations' do
    it 'is valid with an user_id' do
      user = create(:user)
      subscription = build(:subscription, user: user)
      expect(subscription).to be_valid
    end

    it 'is valid with an organization_id' do
      event = create(:event)
      subscription = build(:subscription, event: event)
      expect(subscription).to be_valid
    end

    it 'is invalid without a unique organization_id for given user' do
      user = create(:user)
      event = create(:event)

      create(:subscription, event: event, user: user)

      subscription = build(:subscription,
                           event: event,
                           user: user)
      subscription.valid?
      expect(subscription.errors[:event_id])
        .to include('has already been taken')
    end
  end
end
