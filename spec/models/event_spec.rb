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

require 'rails_helper'

describe Event do
  describe 'Factory' do
    it 'has a valid factory' do
      event = build(:event)
      event.valid?
      expect(event).to be_valid
    end
  end

  describe 'Model Validations' do
    it 'is invalid without required fields' do
      event = build(
        :event,
        title: nil,
        caption: nil,
        scheduled_at: nil,
        link: nil,
        user: nil
      )
      event.valid?
      expect(event).to_not be_valid
      expect(event.errors[:title]).to include("can't be blank")
      expect(event.errors[:caption]).to include("can't be blank")
      expect(event.errors[:scheduled_at]).to include("can't be blank")
      expect(event.errors[:link]).to include("can't be blank")
      expect(event.errors[:user]).to include("can't be blank")
    end
  end

  describe 'Slug generation' do
    it 'generates a slug properly from the title field' do
      event = create(:event, title: '$12 worth of Ruby power')
      expect(event.slug).to eq('12-dollars-worth-of-ruby-power')
    end
  end
end
