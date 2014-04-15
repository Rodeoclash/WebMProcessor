require 'carrierwave/orm/activerecord'

class EncodingJob < ActiveRecord::Base
	mount_uploader :movie, MovieUploader

	MIN_BITRATE = 100
	MAX_BITRATE = 5000

	validates :frame_rate, :numericality => { :greater_than_or_equal_to => ENV['MIN_FRAME_RATE'].to_i, :less_than_or_equal_to => ENV['MAX_FRAME_RATE'].to_i }
	validates :video_bitrate, :numericality => { :greater_than_or_equal_to => ENV['MIN_BIT_RATE'].to_i, :less_than_or_equal_to => ENV['MAX_BIT_RATE'].to_i }
	validates :video_bitrate_tolerance, :numericality => { :greater_than_or_equal_to => ENV['MIN_BIT_RATE_TOLERANCE'].to_i, :less_than_or_equal_to => ENV['MAX_BIT_RATE_TOLERANCE'].to_i }
	validates :video_min_bitrate, :numericality => { :greater_than_or_equal_to => ENV['MIN_BIT_RATE'].to_i }
	validates :video_max_bitrate, :numericality => { :less_than_or_equal_to => ENV['MAX_BIT_RATE'].to_i }
	validates :keyframe_interval, :numericality => { :greater_than_or_equal_to => ENV['MIN_KEYFRAME_INTERVAL'].to_i, :less_than_or_equal_to => ENV['MAX_KEYFRAME_INTERVAL'].to_i }
	validates :buffer_size, :numericality => { :greater_than_or_equal_to => ENV['MIN_BUFFER_SIZE'].to_i, :less_than_or_equal_to => ENV['MAX_BUFFER_SIZE'].to_i }
	validates :duration, :numericality => { :greater_than_or_equal_to => ENV['MIN_DURATION'].to_i, :less_than_or_equal_to => ENV['MAX_DURATION'].to_i }

	default_value_for :video_codec, "libvpx"
	default_value_for :frame_rate, 30
	default_value_for :resolution, "960x720"
	default_value_for :video_bitrate, 750
	default_value_for :video_bitrate_tolerance, 100
	default_value_for :video_max_bitrate, 1500
	default_value_for :video_min_bitrate, 100
	default_value_for :audio_codec, "aac"
	default_value_for :audio_bitrate, 32
	default_value_for :audio_sample_rate, 22050
	default_value_for :audio_channels, 1
	default_value_for :keyframe_interval, 250
	default_value_for :buffer_size, 1500
	default_value_for :threads, 1
	default_value_for :seek_time, 0
	default_value_for :duration, 10
	default_value_for :custom, "-an"

	after_initialize :generate_uuid

	def encoding_options
	{
		video_codec: "libvpx",
		frame_rate: frame_rate,
		resolution: resolution,
		video_bitrate: video_bitrate,
		video_bitrate_tolerance: video_bitrate_tolerance,
		video_max_bitrate: video_max_bitrate,
		video_min_bitrate: video_max_bitrate,
		keyframe_interval: keyframe_interval,
		buffer_size: buffer_size,
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

	def ready_for_encoding?
		self.start_encoding == true
	end

	private

		def generate_uuid
			self.uuid = SecureRandom.uuid unless self.uuid?
		end

end