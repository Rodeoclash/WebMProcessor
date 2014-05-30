require 'carrierwave/orm/activerecord'

class EncodingJob < ActiveRecord::Base
	mount_uploader :movie, MovieUploader

	MIN_BITRATE = 100
	MAX_BITRATE = 5000

	validates :frame_rate, :numericality => { :greater_than_or_equal_to => ENV['MIN_FRAME_RATE'].to_i, :less_than_or_equal_to => ENV['MAX_FRAME_RATE'].to_i }
	validates :video_bitrate, :numericality => { :greater_than_or_equal_to => ENV['MIN_BIT_RATE'].to_i, :less_than_or_equal_to => ENV['MAX_BIT_RATE'].to_i }
	validates :video_bitrate_tolerance, :numericality => { :greater_than_or_equal_to => ENV['MIN_BIT_RATE_TOLERANCE'].to_i, :less_than_or_equal_to => ENV['MAX_BIT_RATE_TOLERANCE'].to_i }
	validates :keyframe_interval, :numericality => { :greater_than_or_equal_to => ENV['MIN_KEYFRAME_INTERVAL'].to_i, :less_than_or_equal_to => ENV['MAX_KEYFRAME_INTERVAL'].to_i }
	validates :duration, :numericality => { :greater_than_or_equal_to => ENV['MIN_DURATION'].to_i, :less_than_or_equal_to => ENV['MAX_DURATION'].to_i }

	default_value_for :video_codec, "libvpx"
	default_value_for :frame_rate, 30
	default_value_for :resolution, "960x720"
	default_value_for :video_bitrate, 750
	default_value_for :video_bitrate_tolerance, 100
	default_value_for :audio_codec, "aac"
	default_value_for :audio_bitrate, 32
	default_value_for :audio_sample_rate, 22050
	default_value_for :audio_channels, 1
	default_value_for :keyframe_interval, 250
	default_value_for :threads, 1
	default_value_for :seek_time, 0
	default_value_for :duration, 10
	default_value_for :custom, "-an -deadline good -cpu-used 0"

	after_initialize :generate_uuid
	before_save :start_transcode

	def encoding_options
		{
			video_codec: "libvpx",
			frame_rate: frame_rate,
			resolution: resolution,
			video_bitrate: video_bitrate,
			video_bitrate_tolerance: video_bitrate_tolerance,
			keyframe_interval: keyframe_interval,
			threads: threads,
			duration: duration,
			seek_time: seek_time,
			custom: custom,
			audio_codec: "libvorbis",
			audio_bitrate: 32,
			audio_sample_rate: 22050,
			audio_channels: 1
		}
	end

	def screenshot_options
		{
			seek_time: 2,
			resolution: '640x480'
		}
	end

	def firebase_progress
		@firebase_progress ||= FirebaseProgress.new(uuid: self.uuid)
	end

	private

		def generate_uuid
			self.uuid = SecureRandom.uuid unless self.uuid?
		end
		
		def ready_for_transcode?
			s3_response && start_encoding == true && queue_job_id.blank?
		end

		def start_transcode
			if ready_for_transcode?
				self.queue_job_id = PerformTranscode.perform_async(self.id)
				self.firebase_progress.update({
					progress_percentage: 0,
					status: "Video placed in transcoding queue, this might take a while so check back soon...",
					ready_for_download: false,
					error_with_transcoding: false
				})
			end
		end

end