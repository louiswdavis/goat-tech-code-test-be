# == Schema Information
#
# Table name: tasks
#
#  id             :bigint           not null, primary key
#  description    :text
#  due_date       :datetime
#  priority       :integer          default("medium"), not null
#  status         :integer          default("todo"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  assigned_to_id :bigint
#  campaign_id    :bigint
#  created_by_id  :bigint
#
# Indexes
#
#  index_tasks_on_assigned_to_id  (assigned_to_id)
#  index_tasks_on_campaign_id     (campaign_id)
#  index_tasks_on_created_by_id   (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (assigned_to_id => users.id)
#  fk_rails_...  (created_by_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :campaign, counter_cache: :task_count # counter_cache could also just be a method but this is my familiar approach
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :assigned_to, class_name: 'User', foreign_key: 'assigned_to_id', optional: true

  validates_presence_of :title
  validates_length_of :title, maximum: 200

  enum status: { todo: 0, in_progress: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
end
