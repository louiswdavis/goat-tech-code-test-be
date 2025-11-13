class AddTaskCountToCampaign < ActiveRecord::Migration[7.1]
  def change
    add_column :campaigns, :task_count, :integer, default: 0 # should normally be tasks_count but renamed to fit requirements
  end
end
