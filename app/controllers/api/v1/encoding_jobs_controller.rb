class Api::V1::EncodingJobsController < ApplicationController
	respond_to :json

	def create
		@encoding_job = EncodingJob.new
		if @encoding_job.save
			@encoding_job.movie.success_action_status = "201" # set inside the encoded policy
			respond_with @encoding_job, serializer: Api::V1::EncodingJobSerializer, location: [:api, :v1, @encoding_job]
		else
			render json: @encoding_job.errors, status: :unprocessable_entity
		end
	end

	def show
		@encoding_job = EncodingJob.where(:uuid => params[:uuid]).first
		respond_with @encoding_job, serializer: Api::V1::EncodingJobSerializer
	end

	def update
		@encoding_job = EncodingJob.where(:uuid => params[:uuid]).first
		if @encoding_job.update(encoding_job_params)
			head :no_content
		else
			render json: @encoding_job.errors, status: :unprocessable_entity
		end
	end

	def upload_movie
		@encoding_job = EncodingJob.where(:uuid => params[:encoding_job_id]).first
		@encoding_job.movie = params[:file]
		if @encoding_job.save
			respond_with @encoding_job, serializer: Api::V1::EncodingJobSerializer, location: [:api, :v1, @encoding_job]
		else
			render json: @encoding_job.errors, status: :unprocessable_entity
		end
	end

	def encoding_job_params
		params.permit(
			:frame_rate,
			:resolution,
			:video_bitrate,
			:video_bitrate_tolerance,
			:video_max_bitrate,
			:video_min_bitrate,
			:keyframe_interval,
			:buffer_size,
			:duration,
			:seek_time,
			:start_encoding,
			:s3_response
		)
	end

end