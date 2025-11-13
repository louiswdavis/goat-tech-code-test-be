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
class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Aliased associations for tasks (when Task is created by candidate)
  # BONUS TASK:
  has_many :created_tasks, class_name: 'Task', foreign_key: 'created_by_id', dependent: :nullify
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assigned_to_id', dependent: :nullify
end
