# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Relationship do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:relationship)).to be_valid
    end
  end

  describe 'Model Validations' do
    it 'is valid with a follower_id and followed_id' do
      user_a = create(:user)
      user_b = create(:user)
      relationship = build(:relationship, follower: user_a, followed: user_b)
      expect(relationship).to be_valid
    end
  end
end
