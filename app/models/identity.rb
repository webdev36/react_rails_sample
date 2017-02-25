# == Schema Information
#
# Table name: identities
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  provider     :string
#  provider_uid :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Identity < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :provider_uid, allow_blank: true, uniqueness: { scope: :provider }
  validates :user_id, uniqueness: { scope: :provider }
end
