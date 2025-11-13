module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]

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
        params.require(:task).permit(:status, :priority)
      end
    end
  end
end
