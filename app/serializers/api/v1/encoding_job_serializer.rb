class Api::V1::EncodingJobSerializer < ActiveModel::Serializer
	attributes	:uuid,
				:frame_rate,
				:resolution,
				:video_bitrate,
				:video_bitrate_tolerance,
				:video_max_bitrate,
				:video_min_bitrate,
				:buffer_size,
				:keyframe_interval,
				:duration,
				:seek_time,
				:files,
				:start_encoding,
				:movie_uploaded_to_s3,
				:s3_settings

	def files
		object.movie
	end

	def s3_settings
		{
			url: "https://#{ENV['AWS_BUCKET']}.s3.amazonaws.com/",
			key: object.movie.key,
			aws_access_key_id: object.movie.aws_access_key_id,
			acl: object.movie.acl,
			success_action_redirect: object.movie.success_action_redirect,
			policy: object.movie.policy,
			signature: object.movie.signature
		}
	end
	
end