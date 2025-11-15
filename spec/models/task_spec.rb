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
require 'rails_helper'

# These tests will fail until you create the Task model
# Run migrations after generating the Task model
RSpec.describe Task, type: :model do
  describe 'validations' do
    # my own check
    subject { FactoryBot.build(:task) }
    specify(:aggregate_failures) do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_length_of(:title).is_at_most(200)
    end

    it 'requires a title' do
      task = Task.new(campaign_id: 1)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'validates title length' do
      task = Task.new(title: 'a' * 201, campaign_id: 1)
      expect(task).not_to be_valid
    end

    it 'requires a campaign' do
      task = Task.new(title: "Test Task")
      expect(task).not_to be_valid
      expect(task.errors[:campaign]).to include("must exist")
    end

    it 'is valid with valid attributes' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.new(title: "Test Task", campaign: campaign)
      expect(task).to be_valid
    end
  end

  describe 'enums' do
    # my own check
    specify(:aggregate_failures) do
      is_expected.to define_enum_for(:status).with_values({ todo: 0, in_progress: 1, done: 2 })
      is_expected.to define_enum_for(:priority).with_values({ low: 0, medium: 1, high: 2 })
    end

    it 'has status enum' do
      expect(Task.statuses).to eq({ "todo" => 0, "in_progress" => 1, "done" => 2 })
    end

    it 'has priority enum' do
      expect(Task.priorities).to eq({ "low" => 0, "medium" => 1, "high" => 2 })
    end

    it 'defaults status to todo' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.create!(title: "Test Task", campaign: campaign)
      expect(task.status).to eq("todo")
    end

    it 'defaults priority to medium' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.create!(title: "Test Task", campaign: campaign)
      expect(task.priority).to eq("medium")
    end
  end

  describe 'associations' do
    # my own check
    specify(:aggregate_failures) do
      is_expected.to belong_to(:campaign).counter_cache(:task_count)
    end

    it 'belongs to campaign' do
      association = Task.reflect_on_association(:campaign)
      expect(association.macro).to eq(:belongs_to)
    end

    # BONUS: User relationship tests
    it 'belongs to created_by user' do
      association = Task.reflect_on_association(:created_by)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:optional]).to be true
    end

    it 'belongs to assigned_to user' do
      association = Task.reflect_on_association(:assigned_to)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:optional]).to be true
    end
  end
end
