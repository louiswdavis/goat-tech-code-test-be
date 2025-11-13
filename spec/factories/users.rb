# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :users do
    sequence(:email) { |n| "account#{n}@goat.com" }
    sequence(:name) { |n| "Joe Bloggs#{n}" }
  end
end
