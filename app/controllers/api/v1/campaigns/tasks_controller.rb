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

          tasks = tasks.includes(:created_by, :assigned_to)
                       .order(status: :desc, priority: :desc, due_date: :desc)
          
          tasks.map do |task| 
            task.attributes.merge(
              created_by_name: task.created_by&.name,
              assigned_to_name: task.assigned_to&.name
            )
          end

          render json: { tasks: tasks }
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
          params.require(:task).permit(:title, :priority, :created_by_id, :assigned_to_id)
        end
      end
    end
  end
end
