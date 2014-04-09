class Api::V1::EncodingJobsController < ApplicationController
	respond_to :json

	def create
		@encoding_job = EncodingJob.find(params[:uuid])
		if @encoding_job.save
			respond_with @encoding_job, serializer: Api::V1::EncodingJobSerializer, location: [:api, :v1, @encoding_job]
		else
			render json: @encoding_job.errors, status: :unprocessable_entity
		end
	end

	def show
		@encoding_job = EncodingJob.find(params[:uuid])
		respond_with @encoding_job, serializer: Api::V1::CampaignSerializer
	end

end