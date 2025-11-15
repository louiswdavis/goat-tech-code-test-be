require 'rails_helper'

# These tests will fail until you create the Task model and controller
RSpec.describe "Api::V1::Tasks", type: :request do
  let!(:campaign) { Campaign.create!(name: "Test Campaign") }
  let!(:user) { User.create!(name: "Test User", email: "test@example.com") }

  describe "GET /api/v1/campaigns/:campaign_id/tasks" do
    before do
      skip "Task model not yet created" unless defined?(Task)
      campaign.tasks.create!(title: "Task 1", status: "todo", priority: "high")
      campaign.tasks.create!(title: "Task 2", status: "done", priority: "low")
    end

    it "returns all tasks for a campaign" do
      get "/api/v1/campaigns/#{campaign.id}/tasks"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['tasks'].length).to eq(2)
    end

    it "filters by status" do
      get "/api/v1/campaigns/#{campaign.id}/tasks?status=todo"
      json = JSON.parse(response.body)
      expect(json['tasks'].length).to eq(1)
      expect(json['tasks'].first['status']).to eq("todo")
    end

    it "filters by priority" do
      get "/api/v1/campaigns/#{campaign.id}/tasks?priority=high"
      json = JSON.parse(response.body)
      expect(json['tasks'].length).to eq(1)
      expect(json['tasks'].first['priority']).to eq("high")
    end
  end

  describe "GET /api/v1/tasks/:id" do
    let!(:task) { campaign.tasks.create!(title: "Test Task") if defined?(Task) }

    it "returns a single task" do
      skip "Task model not yet created" unless defined?(Task)
      get "/api/v1/tasks/#{task.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['task']['title']).to eq("Test Task")
    end
  end

  describe "POST /api/v1/campaigns/:campaign_id/tasks" do
    it "creates a new task" do
      skip "Task model not yet created" unless defined?(Task)

      expect {
        post "/api/v1/campaigns/#{campaign.id}/tasks",
             params: { task: { title: "New Task", priority: "high" } }
      }.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['task']['title']).to eq("New Task")
    end

    it "creates task with user relationships (BONUS)" do
      skip "Task model not yet created" unless defined?(Task)

      post "/api/v1/campaigns/#{campaign.id}/tasks",
           params: {
             task: {
               title: "New Task",
               created_by_id: user.id,
               assigned_to_id: user.id
             }
           }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['task']['created_by_id']).to eq(user.id)
      expect(json['task']['assigned_to_id']).to eq(user.id)
    end
  end

  describe "PATCH /api/v1/tasks/:id" do
    let!(:task) { campaign.tasks.create!(title: "Test Task", status: "todo") if defined?(Task) }

    it "updates a task" do
      skip "Task model not yet created" unless defined?(Task)

      patch "/api/v1/tasks/#{task.id}",
            params: { task: { status: "done", priority: "high" } }

      expect(response).to have_http_status(:success)
      task.reload
      expect(task.status).to eq("done")
      expect(task.priority).to eq("high")
    end
  end

  describe "DELETE /api/v1/tasks/:id" do
    let!(:task) { campaign.tasks.create!(title: "Test Task") if defined?(Task) }

    it "deletes a task" do
      skip "Task model not yet created" unless defined?(Task)

      expect {
        delete "/api/v1/tasks/#{task.id}"
      }.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
