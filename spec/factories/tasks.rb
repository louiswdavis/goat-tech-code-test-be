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
FactoryBot.define do
  factory :task do
    association :campaign

    sequence(:title) { |n| "Organize Tasting Event #{n}" }
    description { "Plan and execute VIP tasting event for food critics"}
    sequence(:due_date) { |n| (Date.today + n.days) }
  end
end
