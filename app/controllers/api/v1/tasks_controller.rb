module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]

      # extra action for FE assement
      def index
        tasks = Task.all.includes(:created_by, :assigned_to)
                        .order(status: :desc, priority: :desc, due_date: :desc)
          
        tasks = tasks.map do |task| 
          task.attributes.merge(
            campaign_name: task.campaign.name,
            created_by_name: task.created_by&.name,
            assigned_to_name: task.assigned_to&.name,
          )
        end
        render json: { tasks: tasks }
      end

      def show
        render json: { task: @task }
      end

      def update
        if @task.update(update_params)
          render json: { task: @task }
        else
          render json: { errors: @task.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_task
        @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      def update_params
        params.require(:task).permit(:title, :description, :status, :priority, :due_date)
      end
    end
  end
end
