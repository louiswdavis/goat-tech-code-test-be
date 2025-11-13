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
  # has_many :tasks, dependent: :destroy # TODO once added

  validates_presence_of :name
  validates_length_of :name, maximum: 100

  enum status: { active: 0, completed: 1, archived: 2 }
end
