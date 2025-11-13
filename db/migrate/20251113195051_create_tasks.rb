class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.integer :status, null: false, default: 0
      t.integer :priority, null: false, default: 1
      t.datetime :due_date
    
      t.belongs_to :campaign
    
      t.timestamps
    end
  end
end
