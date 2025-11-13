# == Schema Information
#
# Table name: campaigns
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  status      :integer          default("active")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Campaign < ApplicationRecord
  # BUG 1:
  validates :description, presence: true
  validates :name, length: { maximum: 100 }

  # BUG 2:
  has_one :tasks

  # BUG 3:
  enum status: [:active, :completed, :archived]
end
