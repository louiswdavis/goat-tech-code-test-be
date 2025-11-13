# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  due_date    :datetime
#  priority    :integer          default("medium"), not null
#  status      :integer          default("todo"), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  campaign_id :bigint
#
# Indexes
#
#  index_tasks_on_campaign_id  (campaign_id)
#
class Task < ApplicationRecord
  belongs_to :campaign, counter_cache: :task_count # counter_cache could also just be a method but this is my familiar approach

  validates_presence_of :title
  validates_length_of :title, maximum: 200

  enum status: { todo: 0, in_progress: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
end
