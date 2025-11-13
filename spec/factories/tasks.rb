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
FactoryBot.define do
  factory :task do
    association :campaign

    sequence(:title) { |n| "Organize Tasting Event #{n}" }
    description { "Plan and execute VIP tasting event for food critics"}
    sequence(:due_date) { |n| (Date.today + n.days) }
  end
end
