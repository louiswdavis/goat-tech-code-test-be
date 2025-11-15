module Api
  module V1
    module Campaigns
      class TasksController < ApplicationController
        before_action :set_campaign

        def index
          filters = { status: params[:status], priority: params[:priority] }.compact
          tasks = if filters.present?
                    @campaign.tasks.where(**filters)
                  else
                    @campaign.tasks
                  end

          render json: { tasks: tasks.order(status: :desc, priority: :desc, due_date: :desc) }
        end

        def create
          task = @campaign.tasks.build(create_params)

          if task.save
            render json: { task: task }, status: :created
          else
            render json: { errors: task.errors }, status: :unprocessable_entity
          end
        end

        private

        def set_campaign
          @campaign = Campaign.find(params[:campaign_id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Campaign not found' }, status: :not_found
        end

        def create_params
          params.require(:task).permit(:title, :description, :status, :priority, :due_date)
        end
      end
    end
  end
end
