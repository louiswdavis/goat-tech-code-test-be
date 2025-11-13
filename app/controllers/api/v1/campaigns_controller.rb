module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy]

      def index
        campaigns = if params[:status]
                      Campaign.where(status: params[:status])
                    else
                      Campaign.all
                    end

        # if BUG 7 was task_count, this is handled via counter_cache column
        render json: { campaigns: campaigns }
      end

      def show
        render json: { campaign: @campaign.as_json(include: :tasks) }
      end

      def create
        campaign = Campaign.new(create_params)

        if campaign.save
          render json: { campaign: campaign }, status: :created
        else
          render json: { errors: campaign.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @campaign.update(update_params)
          render json: { campaign: @campaign }
        else
          render json: { errors: @campaign.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @campaign.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Campaign not found' }, status: :not_found
      end

      def create_params
        params.require(:campaign).permit(:name, :description)
      end
      
      def update_params
        params.require(:campaign).permit(:name, :description, :status)
      end
    end
  end
end