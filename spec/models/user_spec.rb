# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  username               :string
#  first_name             :string
#  last_name              :string
#  facebook_username      :string
#  twitter_username       :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

describe User do
  describe 'Factory' do
    it 'has a valid factory' do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end
  end

  describe 'Model Validations' do
    it 'is invalid without a unique email address' do
      create(:user, email: 'foobar@gmail.com')
      user = build(:user, email: 'foobar@gmail.com')
      user.valid?
      expect(user).to_not be_valid
    end
  end

  describe 'Instance Methods' do
    it 'allows user to follow and unfollow another user' do
      user = create(:user)
      user_b = create(:user)
      user.follow(user_b)
      user.save!
      user.reload
      expect(user.following?(user_b)).to eq(true)
      user.unfollow(user_b)
      user.save!
      user.reload
      expect(user.following?(user_b)).to eq(false)
    end

    it 'allows user to get a list of followers' do
      user = create(:user)
      user_b = create(:user)
      user_c = create(:user)
      user_b.follow(user)
      user_b.save!
      user_c.follow(user)
      user_c.save!

      user.reload
      expect(user.followers.size).to eq(2)
    end

    it 'allows user to get a list of followed users' do
      user = create(:user)
      user_b = create(:user)
      user_c = create(:user)
      user.follow(user_b)
      user.follow(user_c)
      user.save!
      user.reload
      expect(user.following.size).to eq(2)
    end
  end
end
