# == Schema Information
#
# Table name: campaigns
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  status      :integer          default("active")
#  tasks_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :campaigns do
    sequence(:name) { |n| "Burger Town - Mega Burger Launch #{n}" }
    description { "Launching the Mega Burger at Burger Town" }
  end
end
