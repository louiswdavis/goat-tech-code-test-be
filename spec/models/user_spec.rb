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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a name' do
      user = User.new(email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires an email' do
      user = User.new(name: "Test User")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires unique email' do
      User.create!(name: "User 1", email: "test@example.com")
      user = User.new(name: "User 2", email: "test@example.com")
      expect(user).not_to be_valid
    end

    it 'is valid with valid attributes' do
      user = User.new(name: "Test User", email: "test@example.com")
      expect(user).to be_valid
    end
  end

  describe 'associations' do
    it 'has many created_tasks' do
      skip "Task model not yet created" unless defined?(Task)
      association = User.reflect_on_association(:created_tasks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:foreign_key]).to eq('created_by_id')
    end

    it 'has many assigned_tasks' do
      skip "Task model not yet created" unless defined?(Task)
      association = User.reflect_on_association(:assigned_tasks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:foreign_key]).to eq('assigned_to_id')
    end
  end
end
